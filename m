Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:51558 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754720AbaIQNaZ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 17 Sep 2014 09:30:25 -0400
Message-ID: <54198CEE.7000906@xsilon.com>
Date: Wed, 17 Sep 2014 14:30:22 +0100
From: Simon Vincent <simon.vincent@xsilon.com>
MIME-Version: 1.0
Subject: Re: 6lowpan raw socket problems
References: <1409638090.3120.71.camel@jrissane-mobl.ger.corp.intel.com> <20140902071214.GA25800@omega> <20140902072627.GB25800@omega> <5405D284.7020606@xsilon.com> <20140902144327.GA15189@omega> <5405D961.4060006@xsilon.com> <20140902153742.GC15189@omega> <5405EB08.5040006@xsilon.com> <20140902162630.GD15189@omega> <5406123E.2080100@xsilon.com> <20140908104326.GC6981@omega>
In-Reply-To: <20140908104326.GC6981@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

I have been looking into this issue again and it looks like RPL packets 
cause the problem. It looks a bit like the header is not decompressed 
correctly.

When I send a RPL packet I can see lowpan_header_compress is called 
which compresses the header. I can not find where the header is 
decompressed when the packet is received. By the time the packet gets to 
rawv6_recvmsg the src and dest addresses in the header are corrupt.

Is this expected?

Regards

Simon

On 08/09/14 11:43, Alexander Aring wrote:
> On Tue, Sep 02, 2014 at 07:53:50PM +0100, Martin Townsend wrote:
>> On 02/09/14 17:26, Alexander Aring wrote:
>>> On Tue, Sep 02, 2014 at 05:06:32PM +0100, Simon Vincent wrote:
>>>> This is not a problem. There is a fix elsewhere for that.
>>>>
>>>> I am using local-link addresses.
>>>>
>>>> I am seeing funny things like:
>>>> lowpan0: received packet from fe80::203:9a00:41:c864 ->
>>>> 7707:ffff:300:0:9a:300:7b3b:3a1a
>>>>
>>>> Src address fe80::203:9a00:41:c864 does not exist on the network and
>>>> destination address 7707:ffff:300:0:9a:300:7b3b:3a1a does not.
>>>>
>>> Where do you capture this? You know that wireshark on a lowpan interface
>>> is broken?
>>>
>>> - Alex
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-wpan" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Hi Alex,
>>
>> I'm working with Simon and these are from printf statements, we've stepped
>> through the code and seen the same problem.
>>
>> It would be nice to have a better testing environment, you mentioned that
>> you have a virtual setup, does this allow for multiple nodes sending
>> receiving packets like the contiki one? if so do you have instructions on
>> how to setup?
>>
> for testing you could use fakelb or tony's serial virtual interface [0].
> I didn't test both of them, but we need some testing interface of
> course.
>
> The virtual serial interface require the serial driver.
>
> Sorry for my late reply.
>
> [0] https://github.com/tcheneau/virtual-ieee802154-serial

