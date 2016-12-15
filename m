Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-qk0-f179.google.com ([209.85.220.179]:35942 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754071AbcLOUPt (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 15 Dec 2016 15:15:49 -0500
Received: by mail-qk0-f179.google.com with SMTP id n21so69305037qka.3
        for <linux-wpan@vger.kernel.org>; Thu, 15 Dec 2016 12:15:29 -0800 (PST)
Subject: Re: [PATCH 8/8] Makefile: drop -D__CHECK_ENDIAN__ from cflags
References: <1481778865-27667-1-git-send-email-mst@redhat.com>
 <1481778865-27667-9-git-send-email-mst@redhat.com>
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <5186291e-90ed-3070-72ad-d6f78fd1a410@broadcom.com>
Date: Thu, 15 Dec 2016 21:15:23 +0100
MIME-Version: 1.0
In-Reply-To: <1481778865-27667-9-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Vince Bridgers <vbridger@opensource.altera.com>, Jay Cliburn <jcliburn@gmail.com>, Chris Snook <chris.snook@gmail.com>, "Luis R. Rodriguez" <mcgrof@do-not-panic.com>, Kalle Valo <kvalo@codeaurora.org>, Maya Erez <qca_merez@qca.qualcomm.com>, Franky Lin <franky.lin@broadcom.com>, Hante Meuleman <hante.meuleman@broadcom.com>, Stanislaw Gruszka <sgruszka@redhat.com>, Johannes Berg <johannes.berg@intel.com>, Emmanuel Grumbach <emmanuel.grumbach@intel.com>, Luca Coelho <luciano.coelho@intel.com>, Intel Linux Wireless <linuxwifi@intel.com>, Jakub Kicinski <kubakici@wp.pl>, Larry Finger <Larry.Finger@lwfinger.net>, Chaoming Li <chaoming_li@realsil.com.cn>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "David S. Miller" <davem@davemloft.net>, Alexander Aring <aar@pengutronix.de>, Stefan Schmidt <stefan@osg.samsung.com>, Matthias Brugger <matthias.bgg@gmail.com>, linux-bluetooth@vger.kernel.org, linux-can@vger.kernel.org, netdev@vger.kernel.org, nios2-dev@lists.rocketboards.org, linux-wireless@vger.kernel.org, wil6210@qca.qualcomm.com, brcm80211-dev-list.pdl@broadcom.com, devel@driverdev.osuosl.org, linux-wpan@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org

On 15-12-2016 6:15, Michael S. Tsirkin wrote:
> That's the default now, no need for makefiles to set it.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/bluetooth/Makefile                                | 2 --
>  drivers/net/can/Makefile                                  | 1 -
>  drivers/net/ethernet/altera/Makefile                      | 1 -
>  drivers/net/ethernet/atheros/alx/Makefile                 | 1 -
>  drivers/net/ethernet/freescale/Makefile                   | 2 --
>  drivers/net/wireless/ath/Makefile                         | 2 --
>  drivers/net/wireless/ath/wil6210/Makefile                 | 2 --
>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/Makefile | 2 --
>  drivers/net/wireless/broadcom/brcm80211/brcmsmac/Makefile | 1 -

For brcm80211 drivers:

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

Regards,
Arend
