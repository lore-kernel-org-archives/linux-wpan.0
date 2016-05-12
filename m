Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:48913 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751372AbcELAPA (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Wed, 11 May 2016 20:15:00 -0400
Subject: Re: [PATCH bluetooth-next 2/3] ieee802154: add netns support
References: <1462959859-6669-1-git-send-email-aar@pengutronix.de>
 <1462959859-6669-2-git-send-email-aar@pengutronix.de>
 <57334FAA.4080301@osg.samsung.com>
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <94f376f3-6b07-e637-d80b-007168af0eb3@pengutronix.de>
Date: Thu, 12 May 2016 02:14:57 +0200
MIME-Version: 1.0
In-Reply-To: <57334FAA.4080301@osg.samsung.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Nicolas Dichtel <nicolas.dichtel@6wind.com>

Hi,

On 05/11/2016 05:28 PM, Stefan Schmidt wrote:
> Hello.
> 
> On 11/05/16 11:44, Alexander Aring wrote:
>> This patch adds netns support for 802.15.4 subsystem. Most parts are
>> copy&pasted from wireless subsystem, it has the identically userspace
>> API.
>>
>> Cc: Nicolas Dichtel <nicolas.dichtel@6wind.com>
>> Signed-off-by: Alexander Aring <aar@pengutronix.de>
>> ---
>>   include/net/cfg802154.h   | 13 +++++++++
>>   include/net/nl802154.h    |  5 ++++
>>   net/ieee802154/core.c     | 70 ++++++++++++++++++++++++++++++++++++++++++++++-
>>   net/ieee802154/core.h     |  2 ++
>>   net/ieee802154/nl802154.c | 54 ++++++++++++++++++++++++++++++++----
>>   5 files changed, 138 insertions(+), 6 deletions(-)
>>
>> diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
>> index 171cd76..795ca40 100644
>> --- a/include/net/cfg802154.h
>> +++ b/include/net/cfg802154.h
>> @@ -219,9 +219,22 @@ struct wpan_phy {
>>         struct device dev;
>>   +    /* the network namespace this phy lives in currently */
>> +    possible_net_t _net;
>> +
>>       char priv[0] __aligned(NETDEV_ALIGN);
>>   };
>>   +static inline struct net *wpan_phy_net(struct wpan_phy *wpan_phy)
> 
> Hmm if you name the setter wpan_phy_net_set() you might ant to name the getter wpan_phy_net_get() and not only wpan_phy_ne().
> 

Took the naming from wireless stuff, see [0].

I would highly recommend to make similar naming stuff (but not 1:1 the
same). It's easier for maintenance changes from wireless which we want
to add into 802.15.4, the namespace stuff is an example which I think we
could really do the same.

In this case:

wiphy -> wpan_phy.

- Alex

[0] http://lxr.free-electrons.com/source/include/net/cfg80211.h#L3305
