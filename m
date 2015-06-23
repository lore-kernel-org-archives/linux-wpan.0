Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:33514 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753437AbbFWLD2 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 23 Jun 2015 07:03:28 -0400
Received: by wgck11 with SMTP id k11so6340913wgc.0
        for <linux-wpan@vger.kernel.org>; Tue, 23 Jun 2015 04:03:27 -0700 (PDT)
Date: Tue, 23 Jun 2015 13:03:21 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: The 802.15.4 Security Layer
Message-ID: <20150623110316.GA3620@omega>
References: <20150618123154.GB6640@omega>
 <20150621211228.GA713@omega>
 <20150622143328.52bed8b3@zoidberg>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20150622143328.52bed8b3@zoidberg>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Phoebe Buckheister <phoebe.buckheister@itwm.fraunhofer.de>
Cc: linux-wpan@vger.kernel.org

Hi,

On Mon, Jun 22, 2015 at 02:33:28PM +0200, Phoebe Buckheister wrote:
> Hi,
> 
> On Sun, 21 Jun 2015 23:12:29 +0200
> Alexander Aring <alex.aring@gmail.com> wrote:
> 
> > On Thu, Jun 18, 2015 at 02:31:54PM +0200, Alexander Aring wrote:
> > […]
> > 
> > The big question now (for me currently):
> > 
> > The mac802154 security MIB storage, see [0]. Contains very performance
> > related datastructures and I agree do doing that, because on each
> > receiving frame we need to lookup the key by some attributes like
> > addresses etc. The current solution for that is doing a hash and then
> > lookup them in some hash tables. That's perfect, we currently do that
> > also by finding the right fragment inside the 6LoWPAN fragmentation
> > stuff.
> 
> The hash lookups there are not actually perfect in any sense. With many
> security-aware nodes, the 2**6 buckets that are statically configured
> right now may very slow down a lot due to hash collisions.
> 

ok. Maybe we should look into the rhashtable datastructure [0]. It's
"Resizable, Scalable, Concurrent Hash Table" [0].

Anyway, I am fine with the current implementation that's better than
using list implementations, anyway. Thanks for pointing this issue of
statically configuration. We can try to change it later, after doing the
crypto nl802154 stuff.

> > In my opinion, this perfomance stuff should _not_ go into the wpan_dev
> > MIB security configuration and we leave it inside the llsec
> > implementation. Why, I think that? Because handling hashes there are
> > too overkill for just representing the current configuration inside
> > nl802154. Later the HardMAC drivers should not deal with hashes for
> > just representing the current security configuration.
> 
> Agreed. Each driver framework (SoftMAC, HardMAC) Must be free to choose
> its own "ideal" representation (whatever that means).
> 

ok.

> > How we should deal with that then:
> > 
> > Simple using some list stuff which representing the configuration
> > inside the MIB of wpan_dev. On the cfg802154 (setter) callbacks, we
> > know the configuration what the wpan MIB should hold. The llsec
> > (security related tables, the hashes) _and_ MIB wpan_dev (security
> > related tables, simple some list stuff) should be representing the
> > same stuff.
> 
> That will not be entirely possible with HardMAC, at least not without
> some work. If a HardMAC implements llsec and you instruct it to use the
> DEVKEY_RECORD mode, you will have to periodically poll the MAC (or
> receive interrupts) when a new new key has been recorded.The frame
> counters per key may also change wildly at the worst possible times, so
> mirroring them is entirely impossible. When your network has
> encrypted/authenticated traffic, you can at best mirror an old subset of
> the actual state in wpan_dev without generating way too much management
> traffic.
> 

For your example the frame counter:

I agree this sounds crazy to always ask what's the current frame counter
is, that's one example for a MIB attribute that we should not put into
ieee802154 layer.

What I think is to put in ieee802154 a security MIB only for
configuration the necessary "ACL" stuff for key management.

These MIB security settings should the only one which are read/writeable
from userspace over nl802154.

On userspace side there should then no difference between accessing a
SoftMAC or HardMAC transceiver.

> > So llsec is just simple a very performance related security layer
> > implementation of mac802154, similar what a HardMAC driver has on the
> > HardMAC related firmware which doing security stuff.
> > 
> > 
> > The question is now: Should we go that way or really hold hashes stuff
> > into wpan_dev?
> > 
> > I told that I began to programming the MIB handling stuff into
> > nl802154 and wpan-tools. I will show later code, it's based on the
> > idea to simple don't moving the llsec (performance datastructures)
> > into wpan_dev MIB, instead doing list stuff there and fill the llsec
> > MIB by the cfg802154 setters which should be the same inside the MIB
> > wpan_dev structure.
> 
> That is probably not a good idea due to the variability of the actual
> MIB at runtime. For each llsec MIB query, you might have to dump a
> large part of the actual driver MIB to resync your lists with what the
> driver actually knows about the network. It's not as painful as it
> could be since you'd only have to sync in one direction, but that's
> still one sync too many for my comfort.
> 
> If a HardMAC was too slow to respond to such queries in a timely
> manner, that might be wholly different story. You can reliably mirror
> some parts of the MIB (security levels and key descriptors), but those
> are only a fraction of the actual MIB size.
> 

Ok, then what's about to move the "userspace configurable" stuff to
ieee802154?

When a set/add call was successful then simple the ieee802154 mib stuff
will be updated. I know the "device descriptor" contains the frame
counter stuff which is hard to sync with the above layer, but then
simple don't allow to dumping it.

> > I rebased my nl802154 and wpan-tools stuff which I did and figured out
> > that I need to do something for making setting and dumping available.
> > I will show code when it's works.
> > 
> > If this works, then the next step would be that the cfg802154_ops
> > which have the setter/delete callbacks for security MIB settings
> > should fill then the llsec MIB.
> > 
> > I hope it's understandable what I tried to explain here and we can
> > clarify now "How to handle the storage of MIB values". What we need to
> > do for sure is the move of these datastructures into ieee802154 layer.
> 
> I'd much rather move the interface to those structures to the
> ieee802154 layer, and let the actual driver framework implement those
> interface as it wishes. Duplication will not serve us well here, just
> as it has bitten someone already in llsec_params.
> 

Okay, then we do it like the old interface. We should care about that
the security interface is not depending on transceiver setup. The
userspace interface (nl802154) to setup the security stuff should be
always the same.

Moving the "configuration" stuff into the above layer just forbid to
allow different stuff for SoftMAC/HardMAC.

I propose the following plan:

1. Make it like the old interface.

2. Then look what we can add/(moving) into the ieee802154 layer for
   create the somewhat "generic secuiryt configuration layer".


We look at the 2. thing when 1. is done. Is that the way we could go?

- Alex

[0] http://git.kernel.org/cgit/linux/kernel/git/bluetooth/bluetooth-next.git/tree/lib/rhashtable.c
