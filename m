Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:51339 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932233AbaIRPy4 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 18 Sep 2014 11:54:56 -0400
Message-ID: <541B004D.1020609@xsilon.com>
Date: Thu, 18 Sep 2014 16:54:53 +0100
From: Simon Vincent <simon.vincent@xsilon.com>
MIME-Version: 1.0
Subject: Re: 6lowpan raw socket problems
References: <0MXovv-1XrSix456F-00WrKR@mrelayeu.kundenserver.de> <20140918083259.GA3774@omega> <541A99D4.8080509@xsilon.com> <20140918084515.GB3774@omega> <20140918085433.GC3774@omega> <541A9FD3.2030104@xsilon.com> <20140918094401.GB4350@omega> <20140918094501.GC4350@omega> <541AE5E9.3000407@xsilon.com> <20140918141911.GA9262@omega>
In-Reply-To: <20140918141911.GA9262@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, werner@almesberger.net

It looks like in 6lowpan_iphc.c lowpan_header_compress the original ipv6 
header is removed and the compressed header is attached.

These four lines are responsible.
     skb_pull(skb, sizeof(struct ipv6hdr));
     skb_reset_transport_header(skb);
     memcpy(skb_push(skb, hc06_ptr - head), head, hc06_ptr - head);
     skb_reset_network_header(skb);

I don't think we can do this as the skb is being used in other parts of 
the ip stack. Hence when the ipv6 header is read elsewhere the addresses 
become corrupt as they have been overwritten by the 6lowpan compressed 
header.

Any ideas on how to fix this?

Simon

On 18/09/14 15:19, Alexander Aring wrote:
> On Thu, Sep 18, 2014 at 03:02:17PM +0100, Simon Vincent wrote:
>> I have created a small test program that shows this problem. It looks like a
>> race condition as sometimes the addresses are not corrupt.
>>
> Mhh maybe some used after freed and then we copy somewhere garbage sometimes.
> Don't know right now.
>
>> It looks like if the RAW socket gets the packet before the packet hits the
>> 6lowpan layer the addresses are fine. If the packet hits the 6lowpan layer
>> before the RAW socket gets the packet then the addresses are corrupt.
>>
>> The test program can be found here.
>> https://github.com/xsilon/sockdebug
>>
>> I will continue debugging!
>>
> ok, good luck.
>
> - Alex

