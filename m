Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:34981 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752028AbbE0Dqs (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 26 May 2015 23:46:48 -0400
Received: by pdea3 with SMTP id a3so106840754pde.2
        for <linux-wpan@vger.kernel.org>; Tue, 26 May 2015 20:46:47 -0700 (PDT)
Message-ID: <55653E11.3050700@gmail.com>
Date: Wed, 27 May 2015 09:16:25 +0530
From: Varka Bhadram <varkabhadram@gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCH v3 bluetooth-next] ieee802154: add set transmit power
 support
References: <1432655224-7663-1-git-send-email-varkab@cdac.in> <20150526211453.GC2954@omega>
In-Reply-To: <20150526211453.GC2954@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

Hi,

On 05/27/2015 02:44 AM, Alexander Aring wrote:

> Hi,
>
> On Tue, May 26, 2015 at 09:17:04PM +0530, Varka Bhadram wrote:
>> This patch adds transmission power setting support for IEEE-802.15.4
>> devices via nl802154.
>>
>> Signed-off-by: Varka Bhadram <varkab@cdac.in>
>> ---
>>   include/net/cfg802154.h   |    1 +
>>   net/ieee802154/nl802154.c |   29 +++++++++++++++++++++++++++++
>>   net/ieee802154/rdev-ops.h |   12 ++++++++++++
>>   net/ieee802154/trace.h    |   15 +++++++++++++++
>>   net/mac802154/cfg.c       |   19 +++++++++++++++++++
>>   5 files changed, 76 insertions(+)
>>
>> diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
>> index 4de59aa..2e3bb01 100644
>> --- a/include/net/cfg802154.h
>> +++ b/include/net/cfg802154.h
>> @@ -44,6 +44,7 @@ struct cfg802154_ops {
>>   	int	(*set_channel)(struct wpan_phy *wpan_phy, u8 page, u8 channel);
>>   	int	(*set_cca_mode)(struct wpan_phy *wpan_phy,
>>   				const struct wpan_phy_cca *cca);
>> +	int     (*set_tx_power)(struct wpan_phy *wpan_phy, s32 power);
>>   	int	(*set_pan_id)(struct wpan_phy *wpan_phy,
>>   			      struct wpan_dev *wpan_dev, __le16 pan_id);
>>   	int	(*set_short_addr)(struct wpan_phy *wpan_phy,
>> diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
>> index 54f4959..cfdb6e0 100644
>> --- a/net/ieee802154/nl802154.c
>> +++ b/net/ieee802154/nl802154.c
>> @@ -783,6 +783,27 @@ static int nl802154_set_cca_mode(struct sk_buff *skb, struct genl_info *info)
>>   	return rdev_set_cca_mode(rdev, &cca);
>>   }
>>   
>> +static int nl802154_set_tx_power(struct sk_buff *skb, struct genl_info *info)
>> +{
>> +	struct cfg802154_registered_device *rdev = info->user_ptr[0];
>> +	s32 power;
>> +	int i;
>> +
>> +	if (rdev->wpan_phy.flags & WPAN_PHY_FLAG_TXPOWER)
>> +		return -EOPNOTSUPP;
> 	if (!(rdev->wpan_phy.flags & WPAN_PHY_FLAG_TXPOWER))
> 		return -EOPNOTSUPP;
>
> I did it also wrong in the cca mode setting. I recently send a patch for
> fixing this.
>
>> +
>> +	if (!info->attrs[NL802154_ATTR_TX_POWER])
>> +		return -EINVAL;
>> +
>> +	power = nla_get_s32(info->attrs[NL802154_ATTR_TX_POWER]);
>> +
>> +	for (i = 0; i < rdev->wpan_phy.supported.tx_powers_size; i++)
>> +		if (power == rdev->wpan_phy.supported.tx_powers[i])
>> +			return rdev_set_tx_power(rdev, power);
> please add brackets for the for loop.

Done. Send the updated patch to ML.

> Otherwise it's looking good. Do you want also change the stuff for
> wpan-tools? I have the following solution currently for a fast testing
> which works in my first tests:
>
> diff --git a/src/phy.c b/src/phy.c
> index ee0e7ad..285801c 100644
> --- a/src/phy.c
> +++ b/src/phy.c
> @@ -53,14 +53,14 @@ static int handle_tx_power_set(struct nl802154_state *state,
>                                 int argc, char **argv,
>                                 enum id_input id)
>   {
> -       long dbm;
> +       float dbm;
>          char *end;
>   
>          if (argc < 1)
>                  return 1;
>   
>          /* TX_POWER */
> -       dbm = strtol(argv[0], &end, 10);
> +       dbm = strtof(argv[0], &end);
>          if (*end != '\0')
>                  return 1;

I also had same patch in my queue.

Will you add this patch to wpan-tools ?
	or
Do you want me to send this patch to ML.?

-- 
Varka Bhadram

