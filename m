Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54]:36787 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932275AbbFUVMg (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 21 Jun 2015 17:12:36 -0400
Received: by wguu7 with SMTP id u7so54263336wgu.3
        for <linux-wpan@vger.kernel.org>; Sun, 21 Jun 2015 14:12:35 -0700 (PDT)
Received: from omega (p20030064A977E8C4E2CB4EFFFE1BB546.dip0.t-ipconnect.de. [2003:64:a977:e8c4:e2cb:4eff:fe1b:b546])
        by mx.google.com with ESMTPSA id a9sm13984629wiv.13.2015.06.21.14.12.34
        for <linux-wpan@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Jun 2015 14:12:34 -0700 (PDT)
Date: Sun, 21 Jun 2015 23:12:29 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: The 802.15.4 Security Layer
Message-ID: <20150621211228.GA713@omega>
References: <20150618123154.GB6640@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20150618123154.GB6640@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

On Thu, Jun 18, 2015 at 02:31:54PM +0200, Alexander Aring wrote:
...
> At weekend I will try to provide my stuff which I already have done and
> will try to explain what the idea for the next necessary steps are. It's
> just to start a discussion "How do deal with accessing llsec over 
> nl802154/cfg802154".

In my timezone it's still weekend and will provide some more information
about to handling security 802.15.4 in nl802154.

What's the problem?

1. There exist no nl802154 commands/attributes for providing security,
   but this is a small problem. Adding new enums in nl802154 and putting
   logic into nl802154.c

2. The big problem and the question "How to deal with that now" is for
   me the storage of current security configurations. Since the nl802154
   we providing the MIB/PIB structure in ieee802154 layer and not
   mac802154.

   
   What are the difference between these layers?

   The ieee802154 is for the netlink/socket/above layers, the
   underlaying layers are mac802154 (in case of SoftMAC) or driver layer
   (in case of HardMAC layer). HardMAC drivers doesn't exists right now
   and I think we need to move some other code from mac802154 into ieee802154
   layer to providing HardMAC drivers (or they do it in driver layer).

   The current situation of security related MIB stuff:

   Currently everything is stored in internal mac802154 structs and the upper
   layer have some set/del/get callbacks in mlme_ops to access them.
   See [0]. At [0] you see "struct mac802154_llsec sec;" which stores
   the complete security MIB stuff.

   Now, the security related MIB stuff should be stored inside
   ieee802154 and not mac802154. Like other MIB values this is stored
   now inside the wpan_dev structure which extends the netdev structure
   which 802.15.4 related informations. See [1].


What's the problem to doing that?

We need to detect which information is necessary to store the MIB
security related information and which should still be in mac802154 for
handling internal llsec mechanism.

The wpan_dev MIB should represents the current information of security
layer only. In general this looks like:


                       .------------.
             .-------- |  nl802154  | ----------.
             |         '------------'           |
    set(del) |                ^                 |  set(del)      
             v                | get             v
      .------------.          |          .------------.
      | cfg802154  | .----------------.  | cfg802154  |
      '------------' | MIB (wpan_dev) |  '------------'
             |       '----------------'         |
   set(del)  |              ^    ^              | set(del)      
             |              |    |              |            ieee802154
      =================================================================
             |              |    |              |      mac80215/HardMAC
             v              |    |              |
      .------------.        |    |              |
      | mac802154  |        |    |              v
      | .-------.  |        |    |       .------------.
      | | llsec |  |<-------'    ------->|  HardMAC   |
      | '-------'  |     set(del)/get    '------------'
      '------------'


What are the boxes?

nl802154: netlink layer.

cfg802154: the in our case the identically mlme_ops callback structure.

mac802154: the SoftMAC layer.

HardMAC: possible HardMAC layer.

The big "...===..." symbols the layers which things are accessible in
ieee802154 layer and the below layer.

I also mark some get/set at the arrows to see which have "manipulate"
access and which have some "read" access.


Note: The difference in mlme_ops and cfg802154 are no getters are
required. The nl802154 should simple dump the current settings from
wpan_dev structure which stores the actual security MIB.

This is the basic architecture which how it should work by storing
security MIB information.


The big question now (for me currently):

The mac802154 security MIB storage, see [0]. Contains very performance
related datastructures and I agree do doing that, because on each
receiving frame we need to lookup the key by some attributes like
addresses etc. The current solution for that is doing a hash and then
lookup them in some hash tables. That's perfect, we currently do that
also by finding the right fragment inside the 6LoWPAN fragmentation stuff.


In my opinion, this perfomance stuff should _not_ go into the wpan_dev
MIB security configuration and we leave it inside the llsec
implementation. Why, I think that? Because handling hashes there are too
overkill for just representing the current configuration inside
nl802154. Later the HardMAC drivers should not deal with hashes for just
representing the current security configuration.


How we should deal with that then:

Simple using some list stuff which representing the configuration inside
the MIB of wpan_dev. On the cfg802154 (setter) callbacks, we know the
configuration what the wpan MIB should hold. The llsec (security related
tables, the hashes) _and_ MIB wpan_dev (security related tables, simple
some list stuff) should be representing the same stuff.

So llsec is just simple a very performance related security layer
implementation of mac802154, similar what a HardMAC driver has on the
HardMAC related firmware which doing security stuff.


The question is now: Should we go that way or really hold hashes stuff
into wpan_dev?

I told that I began to programming the MIB handling stuff into nl802154
and wpan-tools. I will show later code, it's based on the idea to simple
don't moving the llsec (performance datastructures) into wpan_dev MIB,
instead doing list stuff there and fill the llsec MIB by the cfg802154
setters which should be the same inside the MIB wpan_dev structure.

I rebased my nl802154 and wpan-tools stuff which I did and figured out
that I need to do something for making setting and dumping available. I
will show code when it's works.

If this works, then the next step would be that the cfg802154_ops which
have the setter/delete callbacks for security MIB settings should fill
then the llsec MIB.

I hope it's understandable what I tried to explain here and we can
clarify now "How to handle the storage of MIB values". What we need to
do for sure is the move of these datastructures into ieee802154 layer.

- Alex

[0] http://lxr.free-electrons.com/source/net/mac802154/ieee802154_i.h#L96
[1] http://lxr.free-electrons.com/source/include/net/cfg802154.h#L106
--
To unsubscribe from this list: send the line "unsubscribe linux-wpan" in
