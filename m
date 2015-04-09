Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mailsender.cdac.in ([196.1.113.117]:56264 "EHLO
	mailsender.cdac.in" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751773AbbDIHxP (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 9 Apr 2015 03:53:15 -0400
Message-ID: <55262D0D.8040403@cdac.in>
Date: Thu, 09 Apr 2015 13:11:01 +0530
From: Varka Bhadram <varkab@cdac.in>
MIME-Version: 1.0
Subject: Re: [PATCH bluetooth-next] mac802154: fix transmission power datatype
References: <1428563696-1087-1-git-send-email-varkab@cdac.in> <0B968B37-EA54-47CE-B378-72D0B7CD8267@holtmann.org>
In-Reply-To: <0B968B37-EA54-47CE-B378-72D0B7CD8267@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>, Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-wpan@vger.kernel.org, alex.aring@gmail.com

On 04/09/2015 12:58 PM, Marcel Holtmann wrote:
> Hi Varka,
>
>> Available 802.15.4 devices support multiple power levels,
>> which includes positive and negative values.This patch fix
>> set_txpower() operation arugument type to signed from int
>>
>> Signed-off-by: Varka Bhadram <varkab@cdac.in>
>> ---
>> include/net/mac802154.h |    2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/net/mac802154.h b/include/net/mac802154.h
>> index fb4e8a3d..1213419 100644
>> --- a/include/net/mac802154.h
>> +++ b/include/net/mac802154.h
>> @@ -213,7 +213,7 @@ struct ieee802154_ops {
>> 	int		(*set_hw_addr_filt)(struct ieee802154_hw *hw,
>> 					    struct ieee802154_hw_addr_filt *filt,
>> 					    unsigned long changed);
>> -	int		(*set_txpower)(struct ieee802154_hw *hw, int db);
>> +	int		(*set_txpower)(struct ieee802154_hw *hw, s8 dbm);
> the commit message is pretty much non-sense. int is as signed as s8.

The netlink attribute for the power level is s8. At mac level the values
stored in s8 only [1].

[1]: http://git.kernel.org/cgit/linux/kernel/git/bluetooth/bluetooth-next.git/tree/net/mac802154/driver-ops.h#n61

> Regards
>
> Marcel
>

-- 
Varka Bhadram


-------------------------------------------------------------------------------------------------------------------------------
[ C-DAC is on Social-Media too. Kindly follow us at:
Facebook: https://www.facebook.com/CDACINDIA & Twitter: @cdacindia ]

This e-mail is for the sole use of the intended recipient(s) and may
contain confidential and privileged information. If you are not the
intended recipient, please contact the sender by reply e-mail and destroy
all copies and the original message. Any unauthorized review, use,
disclosure, dissemination, forwarding, printing or copying of this email
is strictly prohibited and appropriate legal action will be taken.
-------------------------------------------------------------------------------------------------------------------------------

