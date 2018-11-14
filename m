Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54068 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727822AbeKOCQI (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Wed, 14 Nov 2018 21:16:08 -0500
Subject: Re: [PATCH V3 1/7] net: lorawan: Add macro and definition for LoRaWAN
References: <20181105.101610.1437737564548154497.davem@davemloft.net>
 <20181114160126.4445-2-starnight@g.ncu.edu.tw>
From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Message-ID: <aaee242e-a287-9db6-4374-73f2ee9fc9d2@suse.de>
Date: Wed, 14 Nov 2018 17:12:13 +0100
MIME-Version: 1.0
In-Reply-To: <20181114160126.4445-2-starnight@g.ncu.edu.tw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Jian-Hong Pan <starnight@g.ncu.edu.tw>
Cc: "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, Dollar Chen <dollar.chen@wtmec.com>, Ken Yu <ken.yu@rakwireless.com>, linux-wpan@vger.kernel.org, Stefan Schmidt <stefan@datenfreihafen.org>

Am 14.11.18 um 17:01 schrieb Jian-Hong Pan:
> This patch adds the macro and definition for the implementation of
> LoRaWAN protocol.
> 
> Signed-off-by: Jian-Hong Pan <starnight@g.ncu.edu.tw>
> ---
> V2:
> - Modify the commit message

Note that both v2 and v3 don't seem to be based on the latest lora-next
branch, as your constants are already queued and used there.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
