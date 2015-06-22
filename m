Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mailgw1.uni-kl.de ([131.246.120.220]:45740 "EHLO
	mailgw1.uni-kl.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754750AbbFVMdf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 22 Jun 2015 08:33:35 -0400
Received: from itwm2.itwm.fhg.de (itwm2.itwm.fhg.de [131.246.191.3])
	by mailgw1.uni-kl.de (8.14.4/8.14.4/Debian-7) with ESMTP id t5MCXTie010662
	for <linux-wpan@vger.kernel.org>; Mon, 22 Jun 2015 14:33:30 +0200
Date: Mon, 22 Jun 2015 14:33:28 +0200
From: Phoebe Buckheister <phoebe.buckheister@itwm.fraunhofer.de>
Subject: Re: The 802.15.4 Security Layer
Message-ID: <20150622143328.52bed8b3@zoidberg>
In-Reply-To: <20150621211228.GA713@omega>
References: <20150618123154.GB6640@omega>
	<20150621211228.GA713@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

Hi,

On Sun, 21 Jun 2015 23:12:29 +0200
Alexander Aring <alex.aring@gmail.com> wrote:

> On Thu, Jun 18, 2015 at 02:31:54PM +0200, Alexander Aring wrote:
> […]
> 
> The big question now (for me currently):
> 
> The mac802154 security MIB storage, see [0]. Contains very performance
> related datastructures and I agree do doing that, because on each
> receiving frame we need to lookup the key by some attributes like
> addresses etc. The current solution for that is doing a hash and then
> lookup them in some hash tables. That's perfect, we currently do that
> also by finding the right fragment inside the 6LoWPAN fragmentation
> stuff.

The hash lookups there are not actually perfect in any sense. With many
security-aware nodes, the 2**6 buckets that are statically configured
right now may very slow down a lot due to hash collisions.

> In my opinion, this perfomance stuff should _not_ go into the wpan_dev
> MIB security configuration and we leave it inside the llsec
> implementation. Why, I think that? Because handling hashes there are
> too overkill for just representing the current configuration inside
> nl802154. Later the HardMAC drivers should not deal with hashes for
> just representing the current security configuration.

Agreed. Each driver framework (SoftMAC, HardMAC) Must be free to choose
its own "ideal" representation (whatever that means).

> How we should deal with that then:
> 
> Simple using some list stuff which representing the configuration
> inside the MIB of wpan_dev. On the cfg802154 (setter) callbacks, we
> know the configuration what the wpan MIB should hold. The llsec
> (security related tables, the hashes) _and_ MIB wpan_dev (security
> related tables, simple some list stuff) should be representing the
> same stuff.

That will not be entirely possible with HardMAC, at least not without
some work. If a HardMAC implements llsec and you instruct it to use the
DEVKEY_RECORD mode, you will have to periodically poll the MAC (or
receive interrupts) when a new new key has been recorded.The frame
counters per key may also change wildly at the worst possible times, so
mirroring them is entirely impossible. When your network has
encrypted/authenticated traffic, you can at best mirror an old subset of
the actual state in wpan_dev without generating way too much management
traffic.

> So llsec is just simple a very performance related security layer
> implementation of mac802154, similar what a HardMAC driver has on the
> HardMAC related firmware which doing security stuff.
> 
> 
> The question is now: Should we go that way or really hold hashes stuff
> into wpan_dev?
> 
> I told that I began to programming the MIB handling stuff into
> nl802154 and wpan-tools. I will show later code, it's based on the
> idea to simple don't moving the llsec (performance datastructures)
> into wpan_dev MIB, instead doing list stuff there and fill the llsec
> MIB by the cfg802154 setters which should be the same inside the MIB
> wpan_dev structure.

That is probably not a good idea due to the variability of the actual
MIB at runtime. For each llsec MIB query, you might have to dump a
large part of the actual driver MIB to resync your lists with what the
driver actually knows about the network. It's not as painful as it
could be since you'd only have to sync in one direction, but that's
still one sync too many for my comfort.

If a HardMAC was too slow to respond to such queries in a timely
manner, that might be wholly different story. You can reliably mirror
some parts of the MIB (security levels and key descriptors), but those
are only a fraction of the actual MIB size.

> I rebased my nl802154 and wpan-tools stuff which I did and figured out
> that I need to do something for making setting and dumping available.
> I will show code when it's works.
> 
> If this works, then the next step would be that the cfg802154_ops
> which have the setter/delete callbacks for security MIB settings
> should fill then the llsec MIB.
> 
> I hope it's understandable what I tried to explain here and we can
> clarify now "How to handle the storage of MIB values". What we need to
> do for sure is the move of these datastructures into ieee802154 layer.

I'd much rather move the interface to those structures to the
ieee802154 layer, and let the actual driver framework implement those
interface as it wishes. Duplication will not serve us well here, just
as it has bitten someone already in llsec_params.

> - Alex
> 
> [0]
> http://lxr.free-electrons.com/source/net/mac802154/ieee802154_i.h#L96
> [1] http://lxr.free-electrons.com/source/include/net/cfg802154.h#L106
> -- To unsubscribe from this list: send the line "unsubscribe
> linux-wpan" in

--
To unsubscribe from this list: send the line "unsubscribe linux-wpan" in
