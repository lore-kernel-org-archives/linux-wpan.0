Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:65455 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751668AbaIRIhn (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 18 Sep 2014 04:37:43 -0400
Message-ID: <541A99D4.8080509@xsilon.com>
Date: Thu, 18 Sep 2014 09:37:40 +0100
From: Simon Vincent <simon.vincent@xsilon.com>
MIME-Version: 1.0
Subject: Re: 6lowpan raw socket problems
References: <0MXovv-1XrSix456F-00WrKR@mrelayeu.kundenserver.de> <20140918083259.GA3774@omega>
In-Reply-To: <20140918083259.GA3774@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

Sorry if I confused you, It is not a fakelb problem I get the same 
problem if I run using real 802.15.4 hardware (mrf24j40). The packet is 
put out by the driver but also sent to the RAW socket.

Simon

On 18/09/14 09:33, Alexander Aring wrote:
> On Thu, Sep 18, 2014 at 08:46:55AM +0100, Simon Vincent wrote:
>> I think what is happening is similar to your theory. The packets are getting sent to the 802.15.4 driver and the compress header function but as we have the raw socket recvmsg the packet is also sent internally to this socket.
>> This is because a raw socket receives all messages that are sent and received.
>> It does appear to be a complex problem. I just need to prove that this is what is happening by inserting more debug.
>>
> mh, ok. Good to know that there is maybe such issue with the fakelb
> driver and 6LoWPAN. Maybe there exists some netdev flag setting or
> something else to avoid this.
>
> You could describe this problem at netdev@vger.kernel.org and maybe the
> guys knows a solution.
>
> At the moment we use's some callbacks for replacing IPv6 with 6LoWPAN
> header which was not made to make this there. This seems to be a global
> architecture problem of the 6LoWPAN stack.
>
> Or we need a another fakelb driver solution, I remember the tun/tap
> interfaces which allow to send/recv packets from/to userspace. They need
> to have similar issues when they have two interfaces and link-local
> addresses. I don't know how they deal with that. This idea is just a shoot
> into the dark. ;-)
>
> - Alex

