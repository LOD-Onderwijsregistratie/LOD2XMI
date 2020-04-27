## Operations


The ambition here is to make models and there elements published as linked data re-usable in different platforms for the development of data traffic and storage. First of all this we need to define an platform independent interface for importing an entire model. This can be achieved with a relatively simple XMI-profile.  At the time of writing this is s good as ready including assurance that changes in de model do not propagate in derived systems without their owners being aware. For that purpose modelelements can be published in different versions. 

But thats is not the end of it.  A matter to consider here is how to transmit changes on existing models. So far we look at three options:

1. Import the entire model again with changes

   Right now this doens't look like a viable option.  Platforms usually have an internal identification scheme for modelelements and it is rather common to discard a provided external identification scheme like the linked data URI's the  strong world-wide candidate for such a thing, the linked URI's.
 
 2. Use XMI.differences
  
   XMI has in in built-in definition for transmitting changes on existing models: adding, deleting and changing. This is meant to synchronize models over different platforms. See for details: https://www.omg.org/spec/XMI/2.5.1/PDF.  Support form platforms is missing and sofar it couldn't be made operational anywhere.

3. Plug in on toolspecific merging facilities

   This option isn't  the best choice unless it's  the only one. For example Enterprise Architect does use XMI for merging and baselining, but it creates it's one definition of a merge file to act on differences. So far no other tools are examined.



