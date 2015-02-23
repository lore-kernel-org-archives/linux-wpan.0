Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f178.google.com ([74.125.82.178]:37672 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751601AbbBWWLm (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 23 Feb 2015 17:11:42 -0500
Received: by wesw55 with SMTP id w55so21668388wes.4
        for <linux-wpan@vger.kernel.org>; Mon, 23 Feb 2015 14:11:41 -0800 (PST)
Date: Mon, 23 Feb 2015 23:11:38 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCHv2 bluetooth-next 1/2] at86rf230: copy pdata to driver
 allocated space
Message-ID: <20150223221135.GD16372@omega>
References: <1424719784-15012-1-git-send-email-alex.aring@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1424719784-15012-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, mkl@pengutronix.de

Marcel,

please drop this serie. I misunderstood the xtal settings.

XTAL_MODE = 0x5 means an external "digital" frequency as souce.

XTAL_TRIM makes sense only, when XTAL_MODE = 0xF, which means doing
"analog" frequency over some crystal.

Sorry about that and thanks to Werner Almesberger for explaining!

I will send a new series to setting the XTAL_TRIM register only, which
makes sense on the most at86rf2xx boards which I have here.

- Alex
