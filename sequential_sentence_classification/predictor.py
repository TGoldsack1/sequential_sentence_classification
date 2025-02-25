from typing import List
from overrides import overrides

from allennlp.common.util import JsonDict, sanitize
from allennlp.data import Instance
from allennlp.predictors.predictor import Predictor


@Predictor.register('SeqClassificationPredictor')
class SeqClassificationPredictor(Predictor):
    """
    Predictor for the abstruct model
    """
    def predict_json(self, json_dict: JsonDict) -> JsonDict:
        pred_labels = []
        sentences = json_dict['sentences']

	#added
        sentences = [s for s in sentences if (s!=None and len(s) >0) ]

        paper_id = json_dict['abstract_id']
        for sentences_loop, _, _, _ in  \
            self._dataset_reader.enforce_max_sent_per_example(sentences):
            
            
            if len(sentences_loop) > 0:
  
                #instance = self._dataset_reader.text_to_instance(abstract_id=0, sentences=sentences_loop)
                instance = self._dataset_reader.text_to_instance(sentences=sentences_loop)
                output = self._model.forward_on_instance(instance)
                idx = output['action_probs'].argmax(axis=1).tolist()
                labels = [self._model.vocab.get_token_from_index(i, namespace='labels') for i in idx]
            else:
                labels = []

            pred_labels.extend(labels)
        if len(pred_labels) < len(sentences):
            pred_labels.extend([None]*(len(sentences)-len(pred_labels))) # if sequence is too long, final sentences will not be classified

        assert len(pred_labels) == len(sentences)
        preds = list(zip(sentences, pred_labels))
        return paper_id, preds
