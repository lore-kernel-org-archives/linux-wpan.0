Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from osg.samsung.com ([64.30.133.232]:56831 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750973AbeDMIuD (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Fri, 13 Apr 2018 04:50:03 -0400
Subject: Re: [PATCH] net: ieee802154: mcr20a: do not leak resources on error
 path
References: <20180412122849.15329-1-stefan@osg.samsung.com>
 <CAJuUDwuPeZhPOFcozP5zO+ZR9OLoDemK5_BPr0F=Rb88NBryBw@mail.gmail.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <1abbb92a-6b44-e9c4-10ab-91943c0b4f9a@osg.samsung.com>
Date: Fri, 13 Apr 2018 10:49:58 +0200
MIME-Version: 1.0
In-Reply-To: <CAJuUDwuPeZhPOFcozP5zO+ZR9OLoDemK5_BPr0F=Rb88NBryBw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Xue Liu <liuxuenetmail@gmail.com>
Cc: linux-wpan - ML <linux-wpan@vger.kernel.org>, Alexander Aring <alex.aring@gmail.com>

Hello.


On 04/12/2018 03:28 PM, Xue Liu wrote:
> Acked-by: Xue Liu <liuxuenetmail@gmail.com>

Thanks for the review, Xue.

>
> On 12 April 2018 at 14:28, Stefan Schmidt <stefan@osg.samsung.com> wrote:
>> We already allocated the device and platform  data at this
>> point. Instead of simply return from the probe function we
>> need to cleanup the resources first.
>>
>> Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
>> ---
>>  drivers/net/ieee802154/mcr20a.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ieee802154/mcr20a.c b/drivers/net/ieee802154/mcr20a.c
>> index 944470d69ba9..de0d7f28a181 100644
>> --- a/drivers/net/ieee802154/mcr20a.c
>> +++ b/drivers/net/ieee802154/mcr20a.c
>> @@ -1309,8 +1309,10 @@ mcr20a_probe(struct spi_device *spi)
>>         /* init buf */
>>         lp->buf = devm_kzalloc(&spi->dev, SPI_COMMAND_BUFFER, GFP_KERNEL);
>>
>> -       if (!lp->buf)
>> -               return -ENOMEM;
>> +       if (!lp->buf) {
>> +               ret = -ENOMEM;
>> +               goto free_dev;
>> +       }
>>
>>         mcr20a_setup_tx_spi_messages(lp);
>>         mcr20a_setup_rx_spi_messages(lp);
>> --
>> 2.14.3
>>
This patch has been applied to the wpan tree and will be
part of the next pull request to net.

regards
Stefan Schmidt
