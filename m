Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33855 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752191AbbFCHNn (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 3 Jun 2015 03:13:43 -0400
Received: by payr10 with SMTP id r10so1167357pay.1
        for <linux-wpan@vger.kernel.org>; Wed, 03 Jun 2015 00:13:43 -0700 (PDT)
Message-ID: <556EA90D.4080203@gmail.com>
Date: Wed, 03 Jun 2015 12:43:17 +0530
From: Varka Bhadram <varkabhadram@gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCH bluetooth-next] nl802154: export supported commands
References: <1433304841-12734-1-git-send-email-varkab@cdac.in> <20150603064950.GB731@omega>
In-Reply-To: <20150603064950.GB731@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, Varka Bhadram <varkab@cdac.in>

On 06/03/2015 12:19 PM, Alexander Aring wrote:

> Hi,
>
> On Wed, Jun 03, 2015 at 09:44:01AM +0530, Varka Bhadram wrote:
>> This patch will export the supported commands by the devices
>> to the user. This is required because user should know supported
>> commands by the IEEE-802.15.4 devices. Drivers that are there in
>> the mainline are not supporting all the functionalities that the
>> core is providing to us.
>>
> I think this is not the reason why this was implemented. You check here
> cfg802154_ops which ends in mac802154 (SoftMAC) OR _possible_ HardMAC drivers.
>
> If you want to make sure that a driver implement it _and_ really sure
> you need to check on ieee802154_ops.
>
> I suppose the real reason why wireless has this implementation, is
> because to check if HardMAC drivers can support a specific command.
> This is because every HardMAC driver should implement then the full
> cfg802154_ops callback structure. It's simple wrong here to say "to
> check if the driver support the functionalities".

I found this thread for the reason used in wireless for implementation.

http://www.spinics.net/lists/linux-wireless/msg29923.html

> You skip the mac802154 layer here, these calls are direct driver-layer
> calls in case of HardMAC driver only.
>
>
> Currently that's why I think such feature has _at_ _the_ _moment_ no
> really big use case, because we don't have any HardMAC driver currently.
> Anyway this prepares to handle HardMAC drivers. After fixing the commit
> message you can add a:
>
> Acked-by: Alexander Aring <alex.aring@gmail.com>

Thanks

-- 
Varka Bhadram

