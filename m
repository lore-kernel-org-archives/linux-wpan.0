Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:55191 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752604AbbKYNuM (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Wed, 25 Nov 2015 08:50:12 -0500
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: Re: [PATCH bluetooth-next 2/4] 6lowpan: add nhc module for GHC
 extension header detection
References: <1442577168-23183-1-git-send-email-stefan@osg.samsung.com>
 <1442577168-23183-3-git-send-email-stefan@osg.samsung.com>
 <20150918214415.GA6872@omega> <20150918221429.GA12228@omega>
Message-ID: <5655BC92.7050908@osg.samsung.com>
Date: Wed, 25 Nov 2015 14:50:10 +0100
MIME-Version: 1.0
In-Reply-To: <20150918221429.GA12228@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, jukka.rissanen@linux.intel.com, linux-bluetooth@vger.kernel.org

Hello.

On 19/09/15 00:14, Alexander Aring wrote:
> On Fri, Sep 18, 2015 at 11:44:15PM +0200, Alexander Aring wrote:
>> Hi,
>>
>> On Fri, Sep 18, 2015 at 01:52:46PM +0200, Stefan Schmidt wrote:
> ....
>
>> btw:
>>
>> Something is wrong at iana registration:
>>
>> https://www.iana.org/assignments/_6lowpan-parameters/_6lowpan-parameters.xhtml#lowpan_nhc
>>
>> For RFC6282 they did each entry for each extension header, for GHC not.
>>
>> Don't know why :-(
>>
>> Also iana says it's
>>
>> 10110EEN whereas RFC7400 says it's 1011EIDN
>>      ^
>>      |
>>      I don't know where this bit comes from.
>>
> it isn't wrong, GHC EID is defined for 0-3 only so the first bit is
> always zero. So 10110 E E N is right whereas:
>
> 1011000N -> Hop
> 1011001N -> Routing
> 1011010N -> Fragment
> 1011011N -> Destination
>
> Seems like Mobility and IPv6 is not defined for GHC.
>
> But I still don't know why iana put it for RFC6282 in a new entry on the
> list for each EID and for GHC they did only one entry for the mask without
> EID bits.

I guess we could ask them if we really want to know.

regards
Stefan Schmidt

