Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:64018 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751296AbaJVIpi (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 22 Oct 2014 04:45:38 -0400
Message-ID: <54476EAF.7090208@xsilon.com>
Date: Wed, 22 Oct 2014 09:45:35 +0100
From: Simon Vincent <simon.vincent@xsilon.com>
MIME-Version: 1.0
Subject: Re: [Linux-zigbee-devel] Questions about the Zigbee in Linux
References: <EBA0C22CC7D5724C87D7C17A60FEE9EE46D85E@SHSMSX101.ccr.corp.intel.com> <20141022082919.GA1603@x61s.guest.pengutronix.de> <EBA0C22CC7D5724C87D7C17A60FEE9EE46E22D@SHSMSX101.ccr.corp.intel.com> <20141022090135.GA2721@x61s.guest.pengutronix.de>
In-Reply-To: <20141022090135.GA2721@x61s.guest.pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, "Zhang, Baoli" <baoli.zhang@intel.com>
Cc: "linux-zigbee-devel@lists.sourceforge.net" <linux-zigbee-devel@lists.sourceforge.net>, "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>


On 22/10/14 10:01, Alexander Aring wrote:
> On Wed, Oct 22, 2014 at 08:27:34AM +0000, Zhang, Baoli wrote:
>> Hi,
>>
>> Great, thanks Alexander.
>>
>> I also don't see the RPL implementation.....not integrated? Or not implemented?
>>
> there exist a couple of tries for kernelspace and userspace RPL.
> Some names are: simpleRPL, linux-rpl, lot's of other which I don't know
> the name anymore.
>
> For me it is important to get a working 802.15.4/6LoWPAN implementation at
> first. But currently there exist no general RPL implementation, some people
> tried to implement a userspace solution.
>
> It would be really nice to have it, but we also detect some critical 6LoWPAN
> bugs which indicates that multicast, etc... was always broken before. :)
>
>
> - Alex
There is a userspace RPL implementation in development [0]. I have been 
testing/fixing this on 6lowpan but it is still very much in progress. It 
will currently setup initial routes but not adapt to links going down. 
The developer is keen for contributions.
Testing RPL has uncovered quite a few bugs in the Linux 6lowpan.

[0] http://unstrung.sandelman.ca

- Simon

