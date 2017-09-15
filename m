Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:50466
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751347AbdIOM0Q (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 15 Sep 2017 08:26:16 -0400
Subject: Re: [PATCH] linux-wpan: Add an IEEE 802.15.4 over LoRa Semtech
 SX1276/77/78/79 device driver
References: <20170910093026.4386-1-starnight@g.ncu.edu.tw>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <fda61128-d27a-8b08-5a31-97e8a57677fe@osg.samsung.com>
Date: Fri, 15 Sep 2017 14:26:10 +0200
MIME-Version: 1.0
In-Reply-To: <20170910093026.4386-1-starnight@g.ncu.edu.tw>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Jian-Hong Pan <starnight@g.ncu.edu.tw>, Alexander Aring <alex.aring@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-wpan@vger.kernel.org, devicetree@vger.kernel.org

Hello.

On 09/10/2017 11:30 AM, Jian-Hong Pan wrote:
> LoRa is an implementation of LPWPAN.
> Chirp Spread Spectrum (CSS) modulation, which is used by LoRa has been
> specified by IEEE 802.15.4a.
> This driver implements IEEE 802.15.4 mac over LoRa physical layer not
> LoRaWAN.

Please see my architectural comments on how to fit in LoRa transceiver 
in my other mail. I have a very specific question on this driver and its 
use with the mac802154 subsystem though.

I had a look at the first datasheet I could find for it 
(http://www.semtech.com/images/datasheet/sx1276_77_78_79.pdf) and 
stumbled over this sentence:
"Standard GFSK, FSK, OOK, and GMSK modulation is also provided
to allow compatibility with existing systems or standards such
as wireless MBUS and IEEE 802.15.4g."

Does this mean the transceiver can run in a mode where it would be 
compatible with an plain (no LoRA support) IEEE 802.15.4g transceiver on 
the same frequency band, subHGZ here?

While we do not have support for the 15.4g extension (MTU size, etc) in 
our stack right now this would be a very interesting first test for the 
driver. If this would be the case.

How did you test your driver so far? Making sure that the device gets 
detected and setup correctly I assume. Did you also do full transmission 
and receive tests with this transceiver and mac802154? If yes, was it 
the same hardware on both sides or different?

regards
Stefan Schmidt
