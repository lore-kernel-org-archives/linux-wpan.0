Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f171.google.com ([74.125.82.171]:50869 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756365AbaISMzw (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 19 Sep 2014 08:55:52 -0400
Received: by mail-we0-f171.google.com with SMTP id p10so2452598wes.16
        for <linux-wpan@vger.kernel.org>; Fri, 19 Sep 2014 05:55:51 -0700 (PDT)
Date: Fri, 19 Sep 2014 14:55:46 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: 6lowpan raw socket problems
Message-ID: <20140919125544.GA2500@omega>
References: <20140918094501.GC4350@omega>
 <541AE5E9.3000407@xsilon.com>
 <20140918141911.GA9262@omega>
 <20140919110854.GA21364@omega>
 <541C133A.7010000@xsilon.com>
 <20140919114549.GA22396@omega>
 <541C1AC2.1010308@xsilon.com>
 <20140919120630.GA23106@omega>
 <20140919123824.GA2407@omega>
 <541C2536.5080308@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <541C2536.5080308@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Simon Vincent <simon.vincent@xsilon.com>
Cc: linux-wpan@vger.kernel.org, werner@almesberger.net

Hi Simon,

On Fri, Sep 19, 2014 at 01:44:38PM +0100, Simon Vincent wrote:
...
> >mhh, take a look on skb_unshare - make a copy of a shared buffe [0].
> >
> >Seems that we could use that to have a copy of the buffer. Don't know if
> >this can work, because we are inside of callback and the caller lost the
> >reference then.
> I tried that earlier! Didn't work as we lost the reference as you say.
> I think if we do it inside lowpan_xmit like you do in your rework we might
> be ok. I will have a go.
> 

Yea, with combination of lowpan_xmit and do a:

skb = skb_unshare(skb, GFP_ATOMIC);

it's woooorrkkinnnnggg.

Output now is:

send_raw_icmp[fe80::2->ff02::1] (on if: 4): Success
recv_raw_icmp[fe80::2%lowpan0->?]
send_raw_icmp[fe80::2->ff02::1] (on if: 4): Success
recv_raw_icmp[fe80::2%lowpan0->?]
send_raw_icmp[fe80::2->ff02::1] (on if: 4): Success
recv_raw_icmp[fe80::2%lowpan0->?]
send_raw_icmp[fe80::2->ff02::1] (on if: 4): Success
recv_raw_icmp[fe80::2%lowpan0->?]
send_raw_icmp[fe80::2->ff02::1] (on if: 4): Success
recv_raw_icmp[fe80::2%lowpan0->?]
send_raw_icmp[fe80::2->ff02::1] (on if: 4): Success
recv_raw_icmp[fe80::2%lowpan0->?]
send_raw_icmp[fe80::2->ff02::1] (on if: 4): Success
recv_raw_icmp[fe80::2%lowpan0->?]
send_raw_icmp[fe80::2->ff02::1] (on if: 4): Success
recv_raw_icmp[fe80::2%lowpan0->?]


Thanks! If you like you can create a patch for the rework branch, then I will
send it when the rework is finished.


So combination what we always talked about solved this issue, crazy...

- Alex

