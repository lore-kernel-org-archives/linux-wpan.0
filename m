Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34331 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751062AbbEXOZP (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 24 May 2015 10:25:15 -0400
Received: by pabru16 with SMTP id ru16so53768494pab.1
        for <linux-wpan@vger.kernel.org>; Sun, 24 May 2015 07:25:14 -0700 (PDT)
Message-ID: <5561DEEA.1050904@gmail.com>
Date: Sun, 24 May 2015 19:53:38 +0530
From: Varka Bhadram <varkabhadram@gmail.com>
MIME-Version: 1.0
Subject: Re: Your recent work on at86rf230 kernel driver
References: <CAK+9TkJKRgvNYzd5DULRAmCQuP19yxqS_god+s7202tXzpeauw@mail.gmail.com> <20150520073812.GA732@omega>
In-Reply-To: <20150520073812.GA732@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, Craig Younkins <craig@freshtemp.com>
Cc: Ian Core <ic@freshtemp.com>, linux-wpan@vger.kernel.org

Hi Alex,

On Wednesday 20 May 2015 01:08 PM, Alexander Aring wrote:

> On Tue, May 19, 2015 at 03:24:24PM -0400, Craig Younkins wrote:
>> Hi Alex,
>>
> ...
>
>> Unfortunately we still don't have it working. Quick question: Should
>> wpan-tools support changing the TX power now? We have tried using
>> wpan-tools commit 64a53f3 with a 212B.
> Getting the values is currently supported and I reworked the transmit
> power _setting_ in the at86rf230 driver. These steps are necessary to
> support the transmit power setting. Varka Bhadram had support the
> _setting_ of transmit power before [0]. He need to rebase his work and
> change to mbm value handling, also he need to update the wpan-tools but
> then it should work.
>
>
> Varka are you already working on this? It's okay to make this now over
> the NL802154_CMD_SET_TX_POWER cmd.

Thanks for remembering work on tx power setting support.

I rebased my work on bluetooth-next master. I will send to ML.

>> pi@raspberrypi ~/wpan-tools $ iwpan phy
>> wpan_phy phy0
>> supported channels:
>> page 0: 0,1,2,3,4,5,6,7,8,9,10
>> page 2: 0,1,2,3,4,5,6,7,8,9,10
>> current_page: 0
>> current_channel: 5
>> cca_mode: 1
>> tx_power: 5
>> capabilities:
>> iftypes: node,monitor
>> channels:
>> page 0: 0,1,2,3,4,5,6,7,8,9,10
>> page 2: 0,1,2,3,4,5,6,7,8,9,10
>> tx_powers:
>> 5,4,3,2,1,0,-1,-2,-3,-4,-5,-6,-7,-8,-9,-10,-11,-12,-13,-14,-15,-16,-17,-18,-19,-20,-21,-22,-23,-24,-25,-26
>> cca_ed_levels:
>> -1e+02,-98,-96,-94,-92,-90,-88,-86,-84,-82,-80,-78,-76,-74,-72,0
> Thanks for this output it shows me an issue with the cca_ed_levels and
> the at86rf212 transceiver.
>
> - Alex
>
> [0] http://www.spinics.net/lists/linux-wpan/msg01560.html

Regards,

-- 
Varka Bhadram.

