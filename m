Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:61670 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754911AbaIRJDS (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 18 Sep 2014 05:03:18 -0400
Message-ID: <541A9FD3.2030104@xsilon.com>
Date: Thu, 18 Sep 2014 10:03:15 +0100
From: Simon Vincent <simon.vincent@xsilon.com>
MIME-Version: 1.0
Subject: Re: 6lowpan raw socket problems
References: <0MXovv-1XrSix456F-00WrKR@mrelayeu.kundenserver.de> <20140918083259.GA3774@omega> <541A99D4.8080509@xsilon.com> <20140918084515.GB3774@omega> <20140918085433.GC3774@omega>
In-Reply-To: <20140918085433.GC3774@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

There is just a single mrf24j40 on the host.
Some of the messages are sent to multicast addresses so this could be 
causing it!
In particular the multicast address is ff02::1a. (all RPL nodes) I guess 
it is likely this has not been implemented in the Linux kernel...

Simon


On 18/09/14 09:54, Alexander Aring wrote:
> On Thu, Sep 18, 2014 at 10:45:15AM +0200, Alexander Aring wrote:
>> On Thu, Sep 18, 2014 at 09:37:40AM +0100, Simon Vincent wrote:
>>> Sorry if I confused you, It is not a fakelb problem I get the same problem
>>> if I run using real 802.15.4 hardware (mrf24j40). The packet is put out by
>>> the driver but also sent to the RAW socket.
>>>
>> Two mrf24j40 on the same host?
> I mean, my theory is that there are two IPv6 _interfaces_ are on the
> same host. Then Linux do some optimization and necessary callbacks for
> replacing 6LoWPAN header header will never called. Linux do this
> optimization because Linux see it's local.
>
> Then doesn't matter if two mrf24j40, fakelb, etc... or some combinations
> of them. :-)
>
> - Alex

