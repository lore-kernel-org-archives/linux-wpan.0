Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from gateway30.websitewelcome.com ([192.185.179.30]:18073 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1762444AbdEWSxO (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>);
        Tue, 23 May 2017 14:53:14 -0400
Received: from cm3.websitewelcome.com (unknown [108.167.139.23])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id B346116DB0
        for <linux-wpan@vger.kernel.org>; Tue, 23 May 2017 13:28:54 -0500 (CDT)
Date: Tue, 23 May 2017 13:28:53 -0500
Message-ID: <20170523132853.Horde.5IEI9rXUtGVpkMBU_IJgXpJ@gator4166.hostgator.com>
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: Re: [PATCH] net: ieee802154: fix potential null pointer dereference
References: <20170523181147.GA32714@embeddedgus>
 <1B82BF85-7AA5-4A52-B0A8-7336DE963567@holtmann.org>
In-Reply-To: <1B82BF85-7AA5-4A52-B0A8-7336DE963567@holtmann.org>
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Harry Morris <h.morris@cascoda.com>, linuxdev@cascoda.com, Alexander Aring <aar@pengutronix.de>, Stefan Schmidt <stefan@osg.samsung.com>, linux-wpan@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Marcel,

Quoting Marcel Holtmann <marcel@holtmann.org>:

> Hi Gustavo,
>
>> Null check at line 918: if (!spi) {, implies spi might be NULL.
>> Function spi_get_drvdata() dereference pointer spi.
>> Move pointer priv assignment after the null check.
>>
>> Addresses-Coverity-ID: 1408888
>> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
>> ---
>> drivers/net/ieee802154/ca8210.c | 3 ++-
>> 1 file changed, 2 insertions(+), 1 deletion(-)
>
> patch has been applied to bluetooth-next tree.
>

Awesome :)

Thanks
--
Gustavo A. R. Silva






