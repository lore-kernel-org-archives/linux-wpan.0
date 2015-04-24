Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:34489 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753082AbbDXFMN (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 24 Apr 2015 01:12:13 -0400
Received: by pacyx8 with SMTP id yx8so38188835pac.1
        for <linux-wpan@vger.kernel.org>; Thu, 23 Apr 2015 22:12:13 -0700 (PDT)
Message-ID: <5539D098.1000203@gmail.com>
Date: Fri, 24 Apr 2015 10:41:52 +0530
From: Varka Bhadram <varkabhadram@gmail.com>
MIME-Version: 1.0
Subject: Re: [RFC bluetooth-next 00/15] ieee802154: add support for phy capabilities
References: <1429807674-24849-1-git-send-email-alex.aring@gmail.com> <5539BA9B.4090903@gmail.com>
In-Reply-To: <5539BA9B.4090903@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, phoebe.buckheister@itwm.fraunhofer.de

On 04/24/2015 09:08 AM, Varka Bhadram wrote:

> On 04/23/2015 10:17 PM, Alexander Aring wrote:
>> Hi,
>>
>> this patch series contains support for phy capabilities. The phy capabilities
>> can be used to check the setting parameters in nl802154 before we calling the
>> according rdev-ops to send them into SoftMAC/Driver(HardMAC) layer. This avoids
>> that we know before sending them to these layers that we know a "-EINVAL" before,
>> this can be used to check all setting parameters in one setting commands like [0].
>> Additional we can now dump the capabilities into userspace so users know what the
>> phy is supported.
>>
>> The initial values for phy capabilities is that if the driver supports the according
>> handling then the full range of 802.15.4 is supported like csma parameters or
>> max frame retries. If the driver doesn't support the setting of these we assume the
>> 802.15.4 standard values which cannot be changed. (If the phy supports that in any
>> way then the driver is broken and need to support that, we assume that the phy
>> doing 802.15.4 defaults). This case is for mac parameters. In case of that the driver
>> supports the according settings like CSMA/frame retries _but_ not the full range of
>> the 802.15.4 then the driver can overwrite this behaviour by changing the capabilities.
>>
>> For phy parameters, if the driver doesn't set anything, then there is also no
>> possibility to change these values from userspace, this is also a lack of support
>> inside the driver then.
>>
>> At least this patch series also includes a rework of setting/reporting
>> tx_powers/cca_ed_levels values.
>>
>>
>> Note: this patch series based on the ("ieee802154: Add trace events for rdev->ops") by
>> Guido Günther <agx@sigxcpu.org>.
>>
>> - Alex
>>
>> [0] http://www.spinics.net/lists/linux-wpan/msg01603.html
>>
>> Alexander Aring (15):
>>   nl802154: cleanup invalid argument handling
>>   at86rf230: remove tabs after define
>>   ieee802154: move validation check out of softmac
>>   mac802154: check for really changes
>>   mac802154: remove check if operation is supported
>>   ieee802154: introduce wpan_phy_supported
>>   ieee802154: add several phy supported handling
>>   ieee802154: add iftypes capability
>>   ieee802154: add support for get tx powers
>>   ieee802154: add support for get cca ed levels
>>   at86rf230: set cca_modes supported flags
>>   at86rf230: add reset states of tx power level
>>   at86rf230: rework tx power support
>>   at86rf230: rework tx cca energy detection level
>>   nl802154: add support for dump phy capabilities
>>
>>  drivers/net/ieee802154/at86rf230.c | 442 ++++++++++++++++++++++---------------
>>  drivers/net/ieee802154/cc2520.c    |   2 +-
>>  drivers/net/ieee802154/fakelb.c    |  30 +--
>>  drivers/net/ieee802154/mrf24j40.c  |   2 +-
>>  include/net/cfg802154.h            |  43 +++-
>>  include/net/mac802154.h            |  19 ++
>>  include/net/nl802154.h             |  79 +++++++
>>  net/ieee802154/nl-phy.c            |   4 +-
>>  net/ieee802154/nl802154.c          | 198 +++++++++++++++--
>>  net/ieee802154/rdev-ops.h          |  23 ++
>>  net/ieee802154/trace.h             |  62 ++++++
>>  net/mac802154/cfg.c                |  85 ++++---
>>  net/mac802154/driver-ops.h         |  24 ++
>>  net/mac802154/main.c               |  32 +++
>>  14 files changed, 787 insertions(+), 258 deletions(-)
>>
> Good your work around phy capabilities for wpan. 
>
> I would suggest to split this series into two.
> One for the cleanup for at86rf230 and other for
> the adding phy capabilities. Review will also be
> easy for us.
>
>
May be this is not the right place to ask this question.

Do you think that patch at [0] required to us..?

That will be useful multi-queue environment. Even though
its better to have this feature.

If you agree include this, patch is on the way.. 

[0]: https://git.kernel.org/cgit/linux/kernel/git/jberg/mac80211-next.git/commit/?h=fast-xmit&id=084d8536fc4f1581f975c1a5fcacd4384555bdcf

Thanks

-- 
Varka Bhadram

