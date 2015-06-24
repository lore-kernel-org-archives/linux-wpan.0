Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:48618 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753266AbbFXN1s (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 24 Jun 2015 09:27:48 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH bluetooth-next 2/3] cfg802154: add PM hooks
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1435138596-25909-2-git-send-email-alex.aring@gmail.com>
Date: Wed, 24 Jun 2015 15:27:38 +0200
Content-Transfer-Encoding: 7bit
Message-Id: <2601CA10-FD40-49CD-9AAA-BD9140552564@holtmann.org>
References: <1435138596-25909-1-git-send-email-alex.aring@gmail.com> <1435138596-25909-2-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de, varkab@cdac.in, Varka Bhadram <varkabhadram@gmail.com>

Hi Alex,

> This patch help to implement suspend/resume in mac802154, these
> hooks will be run before the device is suspended and after it
> resumes.
> 
> Signed-off-by: Varka Bhadram <varkab@cdac.in>
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
> include/net/cfg802154.h   |  2 ++
> net/ieee802154/rdev-ops.h | 20 ++++++++++++++++++++
> net/ieee802154/sysfs.c    | 38 ++++++++++++++++++++++++++++++++++++++
> net/ieee802154/trace.h    | 22 ++++++++++++++++++++++
> 4 files changed, 82 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

