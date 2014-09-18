Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:40607 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932117AbaIRRJo (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 18 Sep 2014 13:09:44 -0400
Received: by mail-wg0-f41.google.com with SMTP id k14so1223642wgh.12
        for <linux-wpan@vger.kernel.org>; Thu, 18 Sep 2014 10:09:43 -0700 (PDT)
Date: Thu, 18 Sep 2014 19:09:40 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: 6lowpan raw socket problems
Message-ID: <20140918170938.GB11661@omega>
References: <20140918084515.GB3774@omega>
 <20140918085433.GC3774@omega>
 <541A9FD3.2030104@xsilon.com>
 <20140918094401.GB4350@omega>
 <20140918094501.GC4350@omega>
 <541AE5E9.3000407@xsilon.com>
 <20140918141911.GA9262@omega>
 <541B004D.1020609@xsilon.com>
 <20140918163008.GC9262@omega>
 <541B1068.4060707@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <541B1068.4060707@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Simon Vincent <simon.vincent@xsilon.com>
Cc: linux-wpan@vger.kernel.org, werner@almesberger.net

On Thu, Sep 18, 2014 at 06:03:36PM +0100, Simon Vincent wrote:
> 
> On 18/09/14 17:30, Alexander Aring wrote:
> >On Thu, Sep 18, 2014 at 04:54:53PM +0100, Simon Vincent wrote:
> >>It looks like in 6lowpan_iphc.c lowpan_header_compress the original ipv6
> >>header is removed and the compressed header is attached.
> >>
> >>These four lines are responsible.
> >>     skb_pull(skb, sizeof(struct ipv6hdr));
> >>     skb_reset_transport_header(skb);
> >>     memcpy(skb_push(skb, hc06_ptr - head), head, hc06_ptr - head);
> >>     skb_reset_network_header(skb);
> >>
> >>I don't think we can do this as the skb is being used in other parts of the
> >>ip stack. Hence when the ipv6 header is read elsewhere the addresses become
> >>corrupt as they have been overwritten by the 6lowpan compressed header.
> >>
> >>Any ideas on how to fix this?
> >>
> >yes, but I don't believe that this makes trouble. <--- or only makes
> >trouble by replacing data, see below.
> >
> >It's called by a callback of header_ops [0].
> >
> >This is for generating the mac header with address information from
> >neighbor discovery cache (mainly destination address) and source
> >addresse (mainly netdev->dev_addr).
> >
> >Another example of this function is ethernet. [1]
> >
> >On [1] you will se that the ethernet header will created there.
> >
> >- Get data from skb for ethhdr (ethernet header)
> >   struct ethhdr *eth = (struct ethhdr *)skb_push(skb, ETH_HLEN);
> >
> >- memcpy(eth->h_source, saddr, ETH_ALEN); <-- source address
> >
> >- memcpy(eth->h_dest, daddr, ETH_ALEN); <-- destination address.
> >
> >
> >So they using the callback there to manipulate the skb here.
> >
> >Another idea is that, maybe we can ADD data but not REPLACING existing
> >data with that. I don't know right now.
> I think what is done in ethernet is fine as they are adding data. But in the
> lowpan_header_compress we are doing a skb_pull to remove the existing ipv6
> header before adding on the new 6lowpan header, so we are replacing the
> existing data.

Yep, then you could try to test what I did there. Simple save the
address information in reserved skb data and then replacing data in
lowpan_xmit callback. This also solves the capture on lowpan interfaces.

lowpan_xmit should be save to replacing the header.

- Alex
