Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:46947
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751663AbdITMcv (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 20 Sep 2017 08:32:51 -0400
Subject: Re: [PATCH bluetooth-next v2 1/1] ieee802154: atusb: Driver for
 Busware HUL dongle
References: <20170914123210.3765-1-j.filzmaier@gmx.at>
 <20170914123210.3765-2-j.filzmaier@gmx.at>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <0c1f69dd-771d-003c-4390-9a25d2995b37@osg.samsung.com>
Date: Wed, 20 Sep 2017 14:32:43 +0200
MIME-Version: 1.0
In-Reply-To: <20170914123210.3765-2-j.filzmaier@gmx.at>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Josef Filzmaier <j.filzmaier@gmx.at>, linux-wpan@vger.kernel.org

Hello.

On 09/14/2017 02:32 PM, Josef Filzmaier wrote:
> Busware manufactured an USB dongle that is quite similar to
> the atben and rzusb USB dongles. that are already supported.
> This patch aims to support the Busware HUL dongle (called
> hulusb) alongside atusb and rzusb. hulusb is using the
> at86rf212 transceiver which is specifically designed to
> support the 700/800/900 MHz wave band.
> 
> The source code is heavily inspired by the existing atusb
> and at86rf2xx drivers.
> 
> Signed-off-by: Josef Filzmaier <j.filzmaier@gmx.at>

Thanks! This patch has been applied to the wpan-next tree and will be part of the next pull request.

regards
Stefan Schmidt
