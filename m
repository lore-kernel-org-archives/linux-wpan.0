Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:57123 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754692AbaIBSxx (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 2 Sep 2014 14:53:53 -0400
Message-ID: <5406123E.2080100@xsilon.com>
Date: Tue, 02 Sep 2014 19:53:50 +0100
From: Martin Townsend <martin.townsend@xsilon.com>
MIME-Version: 1.0
Subject: Re: 6lowpan raw socket problems
References: <1409567774.3120.57.camel@jrissane-mobl.ger.corp.intel.com> <20140901113835.GA21564@omega> <1409638090.3120.71.camel@jrissane-mobl.ger.corp.intel.com> <20140902071214.GA25800@omega> <20140902072627.GB25800@omega> <5405D284.7020606@xsilon.com> <20140902144327.GA15189@omega> <5405D961.4060006@xsilon.com> <20140902153742.GC15189@omega> <5405EB08.5040006@xsilon.com> <20140902162630.GD15189@omega>
In-Reply-To: <20140902162630.GD15189@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, Simon Vincent <simon.vincent@xsilon.com>
Cc: linux-wpan@vger.kernel.org

On 02/09/14 17:26, Alexander Aring wrote:
> On Tue, Sep 02, 2014 at 05:06:32PM +0100, Simon Vincent wrote:
>> This is not a problem. There is a fix elsewhere for that.
>>
>> I am using local-link addresses.
>>
>> I am seeing funny things like:
>> lowpan0: received packet from fe80::203:9a00:41:c864 ->
>> 7707:ffff:300:0:9a:300:7b3b:3a1a
>>
>> Src address fe80::203:9a00:41:c864 does not exist on the network and
>> destination address 7707:ffff:300:0:9a:300:7b3b:3a1a does not.
>>
> Where do you capture this? You know that wireshark on a lowpan interface
> is broken?
>
> - Alex
> --
> To unsubscribe from this list: send the line "unsubscribe linux-wpan" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
Hi Alex,

I'm working with Simon and these are from printf statements, we've 
stepped through the code and seen the same problem.

It would be nice to have a better testing environment, you mentioned 
that you have a virtual setup, does this allow for multiple nodes 
sending receiving packets like the contiki one? if so do you have 
instructions on how to setup?

Many Thanks,
Martin.
