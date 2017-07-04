Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-qt0-f173.google.com ([209.85.216.173]:33084 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751141AbdGDGWM (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 4 Jul 2017 02:22:12 -0400
Received: by mail-qt0-f173.google.com with SMTP id r30so158272743qtc.0
        for <linux-wpan@vger.kernel.org>; Mon, 03 Jul 2017 23:22:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170704010620.u7dhu6zphcn3ub53@omega>
References: <CAAK7Ti_moJ1fzjp2ofM2gph0FUMqR12ar2xnAtdcUXE6so-eQA@mail.gmail.com>
 <20170629141529.a5xuxgh2mlfb645z@omega> <CAAK7Ti8qgCeEkbJLYZikeOQLz8d-uwxUcEdrERuz=Z6ToUG18A@mail.gmail.com>
 <20170701144332.h7wzoqrnwuxtu5hp@omega> <20170704010620.u7dhu6zphcn3ub53@omega>
From: JANARDHANACHARI KELLA <eni.chari@gmail.com>
Date: Tue, 4 Jul 2017 11:52:10 +0530
Message-ID: <CAAK7Ti-TZWw3+iMUEmorqX-LW9WY-VJb2+AGzRrDovvwfBNqLw@mail.gmail.com>
Subject: Re: wpan link status
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

Thank you Alex for you replay.

On Tue, Jul 4, 2017 at 6:36 AM, Alexander Aring <alex.aring@gmail.com> wrote:
>
> Hi,
>
> cc mailinglist because somehow it was dropped...
>
> could be also interested for other people.

sorry,  i forget to do cc mailinglist.

> On Sat, Jul 01, 2017 at 04:43:32PM +0200, Alexander Aring wrote:
>> Hi,
>>
>> On Fri, Jun 30, 2017 at 10:46:25AM +0530, JANARDHANACHARI KELLA wrote:
>> > Hi Alex,
>> >
>> > I found a structure link_status in cotiki/core/net/link status.c
>> >
>> > /* All statistics of a given link */
>> > struct link_stats {
>> >   uint16_t etx;               /* ETX using ETX_DIVISOR as fixed point divisor */
>> >   int16_t rssi;               /* RSSI (received signal strength) */
>> >   uint8_t freshness;          /* Freshness of the statistics */
>> >   clock_time_t last_tx_time;  /* Last Tx timestamp */
>> > };
>> >
>> > are we have, any kind of structures/functions to obtain
>> > etx,rssi,freshness,last_tx_time?
>> >
>>
>> As per peer/link/neighbor information? No not yet. But such idea is on
>> the List [0]. Such information makes for me sense only if you know the
>> peer according to the statistics. If you don't need that, you could
>> maybe readout regmap registers on at86rf2xx/mrf24j40.
>>
>> For my final exam I "hacked" it into the kernel [1]. What I needed was
>> per link info for LQI/ACK (TX_SUCCESS)/NO_ACK.
>>
>> It's actually a hack because... I was not sure about several things
>> (which I don't remember anymore). Thesis made me lazy and it was stupid
>> to hack everything because deadline...
>>
>> Nevertheless, the _architecture_ idea is to handle it like "wireless
>> (802.11) e.g. station dump" (I am sure 802.11 mesh functionality has
>> also such stuff for per peer statistics).
>>
>> I would suggest you to look into wireless subsystem and maybe [1] if you
>> want to add support for it. For HardMAC drivers... let us figure the
>> HardMAC API out when I ever see _real_ support for HardMAC or I get such
>> HardMAC transceiver (I don't own an HardMAC transceiver).
>>
>> - Alex
>>
>> [0] https://github.com/linux-wpan/wpan-tools/issues/6
>> [1] https://github.com/linux-wpan/linux-wpan-next/blob/for-mcr/net/mac802154/node_info.c



-- 
Thanks & Regards

Janardhanachari Kella
Embedded Development Engineer,
E-mail: eni.chari@gmail.com
