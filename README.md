# Metrc-rb#

## A Ruby library for interacting with Metrc ##

Interacting with Metrc's API requires certification. You'll need API keys to use the library.

# What the heck is Metrc anyway???

Metrc is the Cannabis Tracking System (CTS) used in most States where recreational cannabis is legal
(and even in some that still only offer Medical Marijuana). Metrc is built and maintained by MetrcLLC,
and is only accessible to licensees, verified integrators and other authorized entities.

# What's the Metrc API?

While Metrc includes a Web based interface for licensees to interact with, it also includes an API to
allow software vendors to programmatically update Metrc data. The API does not necessarily provide
all of the functionality of the Web based interface, but is the only way 3rd parties can report data
into Metrc.

# Why can't I just start using the API? What possible benefit could this open source project provide?

Every software vendor in the Cannabis space is currently writing their own code for accessing and interacting
with the Metrc API. This library is not intended to be a production ready replacement for writing your own
code (though you're welcome to use it). It provides a partial implementation to highlight some of the
peculiarities others have encountered, hopefully saving some of your sanity in the process.

# What if I'm not using Ruby? #

If you're not fortunate enough to be able to use Ruby, there's also a Javascript library which is
suitable for Node, or similar based projects. Be aware that you can not access the Metrc API
directly from a browser.
