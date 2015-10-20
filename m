Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:59235 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753167AbbJTIEH (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 20 Oct 2015 04:04:07 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.0 \(3094\))
Subject: Re: [PATCH bluetooth-next 1/6] mac802154: llsec: use kzfree
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1444736579-27826-1-git-send-email-alex.aring@gmail.com>
Date: Tue, 20 Oct 2015 10:04:03 +0200
Content-Transfer-Encoding: 7bit
Message-Id: <D1CDE8B2-2956-43F1-85F9-4BE4C4690541@holtmann.org>
References: <1444736579-27826-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de, linux-bluetooth@vger.kernel.org, jukka.rissanen@linux.intel.com

Hi Alex,

> This patch will use kzfree instead kfree for security related
> information which can be offered by acccident.
> 
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
> net/mac802154/llsec.c | 20 ++++++++++----------
> 1 file changed, 10 insertions(+), 10 deletions(-)

all 6 patches have been applied to bluetooth-next tree.

Regards

Marcel

