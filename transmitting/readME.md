## Transmitting

XMI has in in built-in definition for transmitting changes on existing models: adding, deleting and changing. This is the way to synchronize models over different platforms. We need to look in to that. In principle this information is also contained in de original model and in the linked data publication. However we may need to walk this through from te start and see if it's all solid enhough.

Furthermore, the elements of imported models are supposed to be re-used in productmodels like api-specifications. So we cannot simply delete any of it. We can only add new things since the last import and mark with some tagged value that an existing modelelement is expired and replaced with another one. The productmodel then can be improved at a convenient time.

See for details: https://www.omg.org/spec/XMI/2.5.1/PDF
