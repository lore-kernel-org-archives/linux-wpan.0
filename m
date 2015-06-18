Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:53710 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753929AbbFRP6t (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 18 Jun 2015 11:58:49 -0400
Message-ID: <5582EAAD.1090605@xsilon.com>
Date: Thu, 18 Jun 2015 16:58:37 +0100
From: Simon Vincent <simon.vincent@xsilon.com>
MIME-Version: 1.0
Subject: Re: The 802.15.4 Security Layer
References: <20150618123154.GB6640@omega> <5582E6FA.3020101@osg.samsung.com>
In-Reply-To: <5582E6FA.3020101@osg.samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>, Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org

Hi,

On 18/06/15 16:42, Stefan Schmidt wrote:
> Hello.
>
> On 18/06/15 14:31, Alexander Aring wrote:
>> Hi all,
>>
>> I saw the latest discussion about the security layer and wants to open a
>> new thread about discussion for access this layer over nl802154 and
>> putting a "very easy to use" functionality into iwpan.
>>
>> I need to admit, I never tested myself this layer, also I told many
>> times that the step to put security layer functionality into nl802154 is
>> a necessary step. For that reason I declare the security layer as 
>> broken.
>>
>> Several months ago I started to put these functionality into wpan-tools
>> and nl802154. It's just parsing a file at the moment and putting the all
>> relevant entries for key, device, seclevel tables in cfg802154. Nothing
>> more. These tables are handled like an ACL in 802.15.4 (so far I know)
>> and necessary to do the "key lookup" procedure, on receiving decrypted
>> frames.
>>
>> At weekend I will try to provide my stuff which I already have done and
>> will try to explain what the idea for the next necessary steps are. It's
>> just to start a discussion "How do deal with accessing llsec over
>> nl802154/cfg802154".
>>
>> After we can accessing the sec layer over nl802154, we can hopefully 
>> remove
>> the old interface stuff.
>>
>> Does this sounds like a plan?
>
> I think this is a good idea and I would gladly gve this some testing 
> next week. I bet Simon would do as well as he is currently looking 
> into it.
Yes it would nice to tidy this all up and get a stable interface. I 
currently have some time to look at this and do some testing.

- Simon
