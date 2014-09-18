Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:63884 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755665AbaIROC2 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 18 Sep 2014 10:02:28 -0400
Message-ID: <541AE5E9.3000407@xsilon.com>
Date: Thu, 18 Sep 2014 15:02:17 +0100
From: Simon Vincent <simon.vincent@xsilon.com>
MIME-Version: 1.0
Subject: Re: 6lowpan raw socket problems
References: <0MXovv-1XrSix456F-00WrKR@mrelayeu.kundenserver.de> <20140918083259.GA3774@omega> <541A99D4.8080509@xsilon.com> <20140918084515.GB3774@omega> <20140918085433.GC3774@omega> <541A9FD3.2030104@xsilon.com> <20140918094401.GB4350@omega> <20140918094501.GC4350@omega>
In-Reply-To: <20140918094501.GC4350@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, werner@almesberger.net

I have created a small test program that shows this problem. It looks 
like a race condition as sometimes the addresses are not corrupt.

It looks like if the RAW socket gets the packet before the packet hits 
the 6lowpan layer the addresses are fine. If the packet hits the 6lowpan 
layer before the RAW socket gets the packet then the addresses are corrupt.

The test program can be found here.
https://github.com/xsilon/sockdebug

I will continue debugging!

Simon

On 18/09/14 10:45, Alexander Aring wrote:
> On Thu, Sep 18, 2014 at 11:44:01AM +0200, Alexander Aring wrote:
>> On Thu, Sep 18, 2014 at 10:03:15AM +0100, Simon Vincent wrote:
>>> There is just a single mrf24j40 on the host.
>>> Some of the messages are sent to multicast addresses so this could be
>>> causing it!
>>> In particular the multicast address is ff02::1a. (all RPL nodes) I guess it
>>> is likely this has not been implemented in the Linux kernel...
>>>
>> and we comming back to some other issue which Werner Almesberger
>> detected. [0] :-)
>>
>> There are also some IPv6 implementation issues why RPL sometimes not
>> really working.
>>
>> I cc Werner here, hope that's okay.
>>
>> - Alex
>>
>> [0] https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=d1c53c8e870cdedb6fc9550f41c558bab45b5219
> and now really cc Werner, here. Sorry.

