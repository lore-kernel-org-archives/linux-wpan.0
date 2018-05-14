Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from osg.samsung.com ([64.30.133.232]:50118 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754351AbeENPkc (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Mon, 14 May 2018 11:40:32 -0400
Subject: Re: [RFC PATCH wpan-next 1/2] ieee802154: hwsim: add replacement for
 fakelb
References: <20180427212154.29582-1-aring@mojatatu.com>
 <20180427212154.29582-2-aring@mojatatu.com>
 <20180514142938.afncswlenblaea7a@x220t>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <d688a8f2-5414-58ee-74ff-9eccb30abe8d@osg.samsung.com>
Date: Mon, 14 May 2018 17:40:26 +0200
MIME-Version: 1.0
In-Reply-To: <20180514142938.afncswlenblaea7a@x220t>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aring@mojatatu.com>
Cc: linux-wpan@vger.kernel.org, kernel@mojatatu.com

Hello.


On 05/14/2018 04:29 PM, Alexander Aring wrote:
> Hi,
>
> On Fri, Apr 27, 2018 at 05:21:53PM -0400, Alexander Aring wrote:
>> This patch adds a new virtual driver mac802154_hwsim which is based on
>> the fakelb driver.
>> The fakelb driver will get deprecated and hopefully removed someday.
>> The main reason for doing this step is to rename the driver to
>> mac802154_hwsim to have a similar naming scheme as mac80211_hwsim,
>> which is more popular in the 802.11 wireless word and the idea is the
>> same behind this driver.
>>
>> The new features of this driver are to have knowledge about connected
>> edges, which can be changed during runtime. This offers a testing
>> environment for routing protocols e.g. RPL.
>> The default behaviour is still as fakelb: two radios connected to each
>> other. New added radios during runtime will not be connected to other
>> wpan_hwsim instances.
>>
>> The netlink api is not namespace aware on purpose, only the registered
>> wpan_phy's can be moved to namespaces. The physical layer according to
>> wiresless "air" communication can be handled across namespaces.
>>
>> Furthermore the edges can be weighted with the LQI value according IEEE
>> 802.15.4 which offers additional handling to mark bad or good connection
>> indicators to other connected virtual phys.
>>
>> Signed-off-by: Alexander Aring <aring@mojatatu.com>
> somebody (don't cc him, I think he don't want to be public) reported
> about issues with hwsim privetly. I will check on it and enable more
> kernel debugging stuff in kernel hacking feature to see all
> locking/stack issues.

The positive side is that it got some more testing and you got some problems reported. :-)

>
> TO ALL: never send me private (and absolutely no HTML mails) to me to
> report problems. Please do it here.

Agreed. If you have questions please write to the list. There are often other people who can help as well.

regards
Stefan Schmidt
