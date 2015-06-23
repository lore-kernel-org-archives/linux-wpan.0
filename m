Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:57972 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754661AbbFWQA0 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 23 Jun 2015 12:00:26 -0400
Message-ID: <55898297.7060507@xsilon.com>
Date: Tue, 23 Jun 2015 17:00:23 +0100
From: Simon Vincent <simon.vincent@xsilon.com>
MIME-Version: 1.0
Subject: Re: The 802.15.4 Security Layer
References: <20150618123154.GB6640@omega> <5582E6FA.3020101@osg.samsung.com> <5582EAAD.1090605@xsilon.com> <55831F48.4090905@osg.samsung.com> <55897C92.1060207@xsilon.com>
In-Reply-To: <55897C92.1060207@xsilon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org

Hi Alex,

You can ignore the previous email! I have just seen your email from 
Sunday explaining what you have done.
I somehow became unsubscribed from this mailing list over the weekend so 
didn't get the emails...

Simon

On 23/06/15 16:34, Simon Vincent wrote:
> Hi Alex,
>
> Do you have your security/nl802154 work available anywhere I can have 
> a look?
> I am in the process of getting 802.15.4 security working on our 
> devices. I don't want to implement it using the old interface as I 
> will then have to recode our application when llsec moves over to 
> nl802154.
> I have some spare time at the moment to develop/review/test the 
> security layer.
>
> Simon
>
> On 18/06/15 20:43, Stefan Schmidt wrote:
>> Hello.
>>
>> On 18/06/15 17:58, Simon Vincent wrote:
>>> Hi,
>>>
>>> On 18/06/15 16:42, Stefan Schmidt wrote:
>>>> Hello.
>>>>
>>>> On 18/06/15 14:31, Alexander Aring wrote:
>>>>> Hi all,
>>>>>
>>>>> I saw the latest discussion about the security layer and wants to 
>>>>> open a
>>>>> new thread about discussion for access this layer over nl802154 and
>>>>> putting a "very easy to use" functionality into iwpan.
>>>>>
>>>>> I need to admit, I never tested myself this layer, also I told many
>>>>> times that the step to put security layer functionality into 
>>>>> nl802154 is
>>>>> a necessary step. For that reason I declare the security layer as 
>>>>> broken.
>>>>>
>>>>> Several months ago I started to put these functionality into 
>>>>> wpan-tools
>>>>> and nl802154. It's just parsing a file at the moment and putting 
>>>>> the all
>>>>> relevant entries for key, device, seclevel tables in cfg802154. 
>>>>> Nothing
>>>>> more. These tables are handled like an ACL in 802.15.4 (so far I 
>>>>> know)
>>>>> and necessary to do the "key lookup" procedure, on receiving 
>>>>> decrypted
>>>>> frames.
>>>>>
>>>>> At weekend I will try to provide my stuff which I already have 
>>>>> done and
>>>>> will try to explain what the idea for the next necessary steps 
>>>>> are. It's
>>>>> just to start a discussion "How do deal with accessing llsec over
>>>>> nl802154/cfg802154".
>>>>>
>>>>> After we can accessing the sec layer over nl802154, we can 
>>>>> hopefully remove
>>>>> the old interface stuff.
>>>>>
>>>>> Does this sounds like a plan?
>>>>
>>>> I think this is a good idea and I would gladly gve this some 
>>>> testing next week. I bet Simon would do as well as he is currently 
>>>> looking into it.
>>> Yes it would nice to tidy this all up and get a stable interface. I 
>>> currently have some time to look at this and do some testing.
>>
>> You have by any chance some small example code you used for testing 
>> the llc stuff? It would be handy to start with something small and easy.
>>
>> regards
>> Stefan Schmidt
>>
>> -- 
>> To unsubscribe from this list: send the line "unsubscribe linux-wpan" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>

