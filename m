Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f180.google.com ([74.125.82.180]:48479 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756298AbaIRQaP (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 18 Sep 2014 12:30:15 -0400
Received: by mail-we0-f180.google.com with SMTP id q59so1196760wes.11
        for <linux-wpan@vger.kernel.org>; Thu, 18 Sep 2014 09:30:13 -0700 (PDT)
Date: Thu, 18 Sep 2014 18:30:10 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: 6lowpan raw socket problems
Message-ID: <20140918163008.GC9262@omega>
References: <20140918083259.GA3774@omega>
 <541A99D4.8080509@xsilon.com>
 <20140918084515.GB3774@omega>
 <20140918085433.GC3774@omega>
 <541A9FD3.2030104@xsilon.com>
 <20140918094401.GB4350@omega>
 <20140918094501.GC4350@omega>
 <541AE5E9.3000407@xsilon.com>
 <20140918141911.GA9262@omega>
 <541B004D.1020609@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <541B004D.1020609@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Simon Vincent <simon.vincent@xsilon.com>
Cc: linux-wpan@vger.kernel.org, werner@almesberger.net

On Thu, Sep 18, 2014 at 04:54:53PM +0100, Simon Vincent wrote:
> It looks like in 6lowpan_iphc.c lowpan_header_compress the original ipv6
> header is removed and the compressed header is attached.
> 
> These four lines are responsible.
>     skb_pull(skb, sizeof(struct ipv6hdr));
>     skb_reset_transport_header(skb);
>     memcpy(skb_push(skb, hc06_ptr - head), head, hc06_ptr - head);
>     skb_reset_network_header(skb);
> 
> I don't think we can do this as the skb is being used in other parts of the
> ip stack. Hence when the ipv6 header is read elsewhere the addresses become
> corrupt as they have been overwritten by the 6lowpan compressed header.
> 
> Any ideas on how to fix this?
> 
yes, but I don't believe that this makes trouble. <--- or only makes
trouble by replacing data, see below.

It's called by a callback of header_ops [0].

This is for generating the mac header with address information from
neighbor discovery cache (mainly destination address) and source
addresse (mainly netdev->dev_addr).

Another example of this function is ethernet. [1]

On [1] you will se that the ethernet header will created there.

- Get data from skb for ethhdr (ethernet header)
  struct ethhdr *eth = (struct ethhdr *)skb_push(skb, ETH_HLEN);

- memcpy(eth->h_source, saddr, ETH_ALEN); <-- source address

- memcpy(eth->h_dest, daddr, ETH_ALEN); <-- destination address.


So they using the callback there to manipulate the skb here.

Another idea is that, maybe we can ADD data but not REPLACING existing
data with that. I don't know right now.


But I moved this handling out of the create callback of header_ops. This
also fix the issue by running wireshark&co on a lowpan interface.

What I did is only to save the address information in the reserved room
of skb in this callback. [2]

Then running replacing header in the xmit callback of lowpan device. It
looks very different now! I have also splitted the lowpan implementation
in three files "main.c, tx.c, rx.c". Please note that. This code is part
of the rework and I want to fix the wireshark&co issue there.

I don't have a solution for this right now which applies on current
mainline, sorry! But the xmit callback is 100% secure by replacing skb
header data.

If you like you can try to apply it on mainline. What I said is that
this also fix the IPv6 capturing on a lowpan interface. I want also say
to you that I added a comment there "TODO ask david or marc if this run
into trouble", because I am not sure if the reserved skb room can be
overwritten sometimes, then we stuck into the same issue. (Worked on my
side currently), but I also don't do much raw socket RPL messages. ;-)

What I know is that we can't use skb->cb here to save the information,
this would be overwritten by traffic control.

- Alex

[0] http://lxr.free-electrons.com/source/include/linux/netdevice.h#L255
[1] http://lxr.free-electrons.com/source/net/ethernet/eth.c#L78
[2] https://github.com/linux-wpan/linux-wpan-next/blob/7ccf5a24a19a72b857bbcbc76342f4838dd85d6b/net/ieee802154/6lowpan/tx.c#L59
[3] https://github.com/linux-wpan/linux-wpan-next/blob/7ccf5a24a19a72b857bbcbc76342f4838dd85d6b/net/ieee802154/6lowpan/tx.c#L261
