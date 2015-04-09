Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:51240 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751618AbbDIHrB (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 9 Apr 2015 03:47:01 -0400
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH bluetooth-next] mac802154: fix transmission power datatype
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <55262D0D.8040403@cdac.in>
Date: Thu, 9 Apr 2015 00:46:43 -0700
Content-Transfer-Encoding: 7bit
Message-Id: <1E49928F-28CB-416C-B22D-2F56CEAAAEBA@holtmann.org>
References: <1428563696-1087-1-git-send-email-varkab@cdac.in> <0B968B37-EA54-47CE-B378-72D0B7CD8267@holtmann.org> <55262D0D.8040403@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkab@cdac.in>
Cc: Varka Bhadram <varkabhadram@gmail.com>, linux-wpan@vger.kernel.org, alex.aring@gmail.com

Hi Varka,

>>> Available 802.15.4 devices support multiple power levels,
>>> which includes positive and negative values.This patch fix
>>> set_txpower() operation arugument type to signed from int
>>> 
>>> Signed-off-by: Varka Bhadram <varkab@cdac.in>
>>> ---
>>> include/net/mac802154.h |    2 +-
>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>> 
>>> diff --git a/include/net/mac802154.h b/include/net/mac802154.h
>>> index fb4e8a3d..1213419 100644
>>> --- a/include/net/mac802154.h
>>> +++ b/include/net/mac802154.h
>>> @@ -213,7 +213,7 @@ struct ieee802154_ops {
>>> 	int		(*set_hw_addr_filt)(struct ieee802154_hw *hw,
>>> 					    struct ieee802154_hw_addr_filt *filt,
>>> 					    unsigned long changed);
>>> -	int		(*set_txpower)(struct ieee802154_hw *hw, int db);
>>> +	int		(*set_txpower)(struct ieee802154_hw *hw, s8 dbm);
>> the commit message is pretty much non-sense. int is as signed as s8.
> 
> The netlink attribute for the power level is s8. At mac level the values
> stored in s8 only [1].

sure, but the commit message is still non-sense.

Regards

Marcel

