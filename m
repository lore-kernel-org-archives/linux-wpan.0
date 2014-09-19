Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:41918 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755094AbaISKPn (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 19 Sep 2014 06:15:43 -0400
Received: by mail-wg0-f47.google.com with SMTP id l18so2182267wgh.30
        for <linux-wpan@vger.kernel.org>; Fri, 19 Sep 2014 03:15:41 -0700 (PDT)
Date: Fri, 19 Sep 2014 12:15:36 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: 6lowpan raw socket problems
Message-ID: <20140919101534.GA19542@omega>
References: <20140918094501.GC4350@omega>
 <541AE5E9.3000407@xsilon.com>
 <20140918141911.GA9262@omega>
 <541B004D.1020609@xsilon.com>
 <20140918163008.GC9262@omega>
 <541B1068.4060707@xsilon.com>
 <20140918170938.GB11661@omega>
 <541BE8D9.2000700@xsilon.com>
 <20140919093335.GB17051@omega>
 <541BFE0C.1050707@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <541BFE0C.1050707@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Simon Vincent <simon.vincent@xsilon.com>
Cc: linux-wpan@vger.kernel.org, werner@almesberger.net, mkl@pengutronix.de

On Fri, Sep 19, 2014 at 10:57:32AM +0100, Simon Vincent wrote:
> 
> On 19/09/14 10:33, Alexander Aring wrote:
> >On Fri, Sep 19, 2014 at 09:27:05AM +0100, Simon Vincent wrote:
> >...
> >>>Yep, then you could try to test what I did there. Simple save the
> >>>address information in reserved skb data and then replacing data in
> >>>lowpan_xmit callback. This also solves the capture on lowpan interfaces.
> >>>
> >>>lowpan_xmit should be save to replacing the header.
> >>I am not 100% sure it is safe to replace the header at any point. How can
> >me, too. We need to check that.
> >
> >>you guarantee that the skb has been read by the user application RAW socket
> >>by this point? The user might not read the socket for seconds/minutes/hours.
> >>
> >no this can't happen. I need to dig into the code and running some
> >ftrace to check if this can work. The RAW socket should not involved here.
> >
> >My theory is:
> >
> >The current behaviour is maybe (Maybe, because it's an assumption).
> >
> >  - IPv6 neighbor discovery magic
> >    - calling create callback of header ops
> >      This callback is only there to add data there not replacing data.
> >      We do REPLACING the data so we can't parse the skb IPv6 header
> >      anymore.
> >    - After calling create callback of header ops IPv6 stack parse the
> >      IPv6 header data which is inside of skb. We already replaced the
> >      IPv6 header with 6LoWPAN header, so we can't parse it anymore but
> >      IPv6 does it. -> WEIRD things happen.
> >    - Finally lowpan interface calling xmit callback, this is at the end
> >      of doing Layer 3 things, so we should sure that nobody parse it there.
> >      What we do there is to queue the skb in the lower wpan interface.
> >
> >
> >The solution would be (maybe):
> >  - IPv6 neighbor discovery magic
> >    - calling create callback of header ops
> >      Putting necessary address information in skb reserved data. What
> >      this means, see below. We don't replace the IPv6 header.
> >    - After calling create callback of header ops IPv6 stack parse the
> >      IPv6 header data which is inside of skb. We don't replace the
> >      IPv6 header with 6LoWPAN header. -> all things are fine.
> >    - Finally lowpan interface calling xmit callback, this is at the end
> >      of doing Layer 3 things. Here we start to replacing IPv6 header
> >      with 6LoWPAN header. The thing is, we need the address information
> >      from create callback, that's why we saved it in skb reserved data.
> >
> 
> It does not look like it is safe to do it at xmit callback either. I have
> added debug printing out skb_shinfo(skb)->dataref in the compress function
> as well as the lowpan_xmit function and there are 3 refs to the data at both
> points. This makes sense as the packet would be sent to the
> 802.15.4/ethernet/rawsocket as it is a multicast packet.
> I think the only solution is to do a full copy of the packet in the 6lowpan
> layer. Then we can modify the headers as much as we like. I know there is an
> overhead doing this but I can't see another way of avoiding this issue.
> 

Can't follow here, I mean inside the xmit callback there is no layer 3
(IPv6) parsing, etc. anymore. So skb_network_header parsing as IPv6
header can't occur here.

Can you send a RFC about your solution? Then it's maybe more clear for
me.

- Alex
