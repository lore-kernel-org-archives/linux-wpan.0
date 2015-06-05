Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:59237 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751774AbbFEVmh (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Fri, 5 Jun 2015 17:42:37 -0400
Message-ID: <557217C9.8050502@osg.samsung.com>
Date: Fri, 05 Jun 2015 23:42:33 +0200
From: Stefan Schmidt <stefan@osg.samsung.com>
MIME-Version: 1.0
Subject: Re: [PATCH wpan-misc] website: adding a list with links to many relevant
 specifications
References: <1433516575-16891-1-git-send-email-stefan@osg.samsung.com> <20150605173623.GA3023@thanatos>
In-Reply-To: <20150605173623.GA3023@thanatos>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Christoffer Holmstedt <christoffer@christofferholmstedt.se>
Cc: linux-wpan@vger.kernel.org, Alexander Aring <alex.aring@gmail.com>

Hello.

On 05/06/15 19:36, Christoffer Holmstedt wrote:
> On Fri, Jun 05, 2015 at 05:02:55PM +0200, Stefan Schmidt wrote:
>> This does not cover all and some other might be missing and some might not be
>> to relevant to us but it is a start for people to start digging into it.
>>
>> Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
>> ---
>>   website/index.txt | 35 +++++++++++++++++++++++++++++++++++
>>   1 file changed, 35 insertions(+)
>>
>> diff --git a/website/index.txt b/website/index.txt
>> index 19d1e70..0213f00 100644
>> --- a/website/index.txt
>> +++ b/website/index.txt
>> @@ -173,4 +173,39 @@ The rework will contains a new netlink API and a general handling about frame cr
>>   
>>   For the nl802154 framework you will need the wpan-tools, older kernels need lowpan-tools but this is not recommended.
>>   
>> +
>> +Specifications
>> +~~~~~~~~~~~~~~
>> +
>> +* http://www.ieee802.org/15/pub/TG4.html[IEEE]:
>> +** http://standards.ieee.org/about/get/802/802.15.html
>> +** 802.15.4-2003
>> +** 802.15.4-2006
>> +** 802.15.4-2011
>> +** 802.15.4a-2007
>> +** 802.15.4c-2009
>> +** 802.15.4d-2009
>> +** 802.15.4e-2012
>> +** 802.15.4f-2012
>> +** 802.15.4g-2012
>> +** 802.15.4j-2013
>> +** 802.15.4k-2013
>> +** 802.15.4m-2014
>> +** 802.15.4p-2014
> ...cut...
>
> I would sort the standards list by year instead of name as the a - d amendments
> should be included in the 2011 version afaik. Just a small detail, no big deal.

Fair enough. Updated patch send as in-reply-to. Thanks for the review!

regards
Stefan Schmidt

> To unsubscribe from this list: send the line "unsubscribe linux-wpan" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

