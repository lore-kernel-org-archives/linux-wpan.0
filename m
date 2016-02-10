Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mx1.snt.utwente.nl ([130.89.149.33]:42314 "EHLO
	mx1.snt.utwente.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751994AbcBJKLK (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 10 Feb 2016 05:11:10 -0500
Subject: Re: [PATCH bluetooth-next] Fixes kernel oops when unloading the radio
 module
References: <1454448364-22417-1-git-send-email-koen@bergzand.net>
 <56B3665F.4070503@osg.samsung.com>
From: Koen Zandberg <koen@bergzand.net>
Message-ID: <56BB0B0C.10108@bergzand.net>
Date: Wed, 10 Feb 2016 11:03:56 +0100
MIME-Version: 1.0
In-Reply-To: <56B3665F.4070503@osg.samsung.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>, linux-wpan@vger.kernel.org

Hello,

On 4-2-2016 15:55, Stefan Schmidt wrote:
> Hello.
>
> Please add a mac802154 as prefix to your subject line to make clear 
> where the patch belongs to.
>
>
> On 02/02/16 22:26, Koen Zandberg wrote:
>> Destroying the workqueue before unregistering the net device caused a
>> kernel oops
>>
>> Signed-off-by: Koen Zandberg <koen@bergzand.net>
>> ---
>>   net/mac802154/main.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/net/mac802154/main.c b/net/mac802154/main.c
>> index e8cab5b..87da85a 100644
>> --- a/net/mac802154/main.c
>> +++ b/net/mac802154/main.c
>> @@ -218,7 +218,6 @@ void ieee802154_unregister_hw(struct 
>> ieee802154_hw *hw)
>>         tasklet_kill(&local->tasklet);
>>       flush_workqueue(local->workqueue);
>> -    destroy_workqueue(local->workqueue);
>>         rtnl_lock();
>>   @@ -226,6 +225,7 @@ void ieee802154_unregister_hw(struct 
>> ieee802154_hw *hw)
>>         rtnl_unlock();
>>   +    destroy_workqueue(local->workqueue);
>>       wpan_phy_unregister(local->phy);
>
> When I look at the cleanup part of ieee802154_register_hw() we call 
> these two in a different order. Should we do the same here or can we 
> be sure that these two are orthogonal and the order do not matter here.
I'm not completly sure whether the order matters in the ieee802154. It 
seems that mac80211 does it reversed, first registering the wiphy and 
then creating the work queue with the failure handling destroying the 
workqueue first and the wiphy unregistering second. I'm not 
knowledgeable enough about these things to make a good call about 
whether to switch them in the ieee802154_hw_register too.

regards
Koen Zandberg
