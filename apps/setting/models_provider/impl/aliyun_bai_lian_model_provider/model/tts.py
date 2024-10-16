from typing import Dict

import dashscope
from dashscope.audio.tts_v2 import *

from setting.models_provider.base_model_provider import MaxKBBaseModel
from setting.models_provider.impl.base_tts import BaseTextToSpeech


class AliyunBaiLianTextToSpeech(MaxKBBaseModel, BaseTextToSpeech):
    api_key: str
    model: str
    voice: str
    speech_rate: float

    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        self.api_key = kwargs.get('api_key')
        self.model = kwargs.get('model')
        self.voice = kwargs.get('voice', 'longxiaochun')
        self.speech_rate = kwargs.get('speech_rate', 1.0)

    @staticmethod
    def new_instance(model_type, model_name, model_credential: Dict[str, object], **model_kwargs):
        optional_params = {}
        if 'voice' in model_kwargs and model_kwargs['voice'] is not None:
            optional_params['voice'] = model_kwargs['voice']
        if 'speech_rate' in model_kwargs and model_kwargs['speech_rate'] is not None:
            optional_params['speech_rate'] = model_kwargs['speech_rate']
        return AliyunBaiLianTextToSpeech(
            model=model_name,
            api_key=model_credential.get('api_key'),
            **optional_params,
        )

    def check_auth(self):
        self.text_to_speech('你好')

    def text_to_speech(self, text):
        dashscope.api_key = self.api_key
        synthesizer = SpeechSynthesizer(model=self.model, voice=self.voice, speech_rate=self.speech_rate)
        audio = synthesizer.call(text)
        if type(audio) == str:
            print(audio)
            raise Exception(audio)
        return audio
