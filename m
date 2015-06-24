Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:48385 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753218AbbFXN1o convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 24 Jun 2015 09:27:44 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH bluetooth-next 3/3] mac802154: cfg: add suspend and resume callbacks
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1435138596-25909-3-git-send-email-alex.aring@gmail.com>
Date: Wed, 24 Jun 2015 15:27:35 +0200
Content-Transfer-Encoding: 8BIT
Message-Id: <AAFC9EE0-1950-484D-8D5B-1AD64E9110A6@holtmann.org>
References: <1435138596-25909-1-git-send-email-alex.aring@gmail.com> <1435138596-25909-3-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de, varkab@cdac.in

Hi Alex,

> This patch introduces suspend and resume callbacks to mac802154. When
> doing suspend we calling the stop driver callback which should stop the
> receiving of frames. A transceiver should go into low-power mode then.
> Calling resume will call the start driver callback, which starts receiving
> again and allow to transmit frames.
> 
> This was tested only with the fakelb driver and a qemu vm by doing the
> following commands:
> 
> echo "devices" > /sys/power/pm_test
> echo "freeze" > /sys/power/state
> 
> while doing some high traffic between two fakelb phys.
> 
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
> net/mac802154/cfg.c          | 45 ++++++++++++++++++++++++++++++++++++++++++++
> net/mac802154/ieee802154_i.h |  1 +
> net/mac802154/rx.c           | 10 ++++++++--
> 3 files changed, 54 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

