Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:39964 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752333AbbBBFK4 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 2 Feb 2015 00:10:56 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH bluetooth-next] ieee802154: cc2520: Replace shift operations by BIT macro
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1422021509-18877-1-git-send-email-md.jamalmohiuddin@gmail.com>
Date: Sun, 1 Feb 2015 21:10:39 -0800
Content-Transfer-Encoding: 7bit
Message-Id: <9000AC78-D8DB-4FE3-86A1-666DE5A1295E@holtmann.org>
References: <1422021509-18877-1-git-send-email-md.jamalmohiuddin@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Mohammad Jamal <md.jamalmohiuddin@gmail.com>
Cc: varkabhadram@gmail.com, alex.aring@gmail.com, linux-wpan@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Mohammad,

> This patch replaces the shifting operations by BIT macro
> 
> Signed-off-by: Mohammad Jamal <md.jamalmohiuddin@gmail.com>
> ---
> drivers/net/ieee802154/cc2520.c |    6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

