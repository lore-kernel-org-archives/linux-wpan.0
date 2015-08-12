Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:36533 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750870AbbHLIsM (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 12 Aug 2015 04:48:12 -0400
Received: by wicja10 with SMTP id ja10so104454529wic.1
        for <linux-wpan@vger.kernel.org>; Wed, 12 Aug 2015 01:48:11 -0700 (PDT)
Date: Wed, 12 Aug 2015 10:48:05 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH wpan-tools] mac: add handling for ackreq default handling
Message-ID: <20150812084801.GA31881@omega>
References: <1438772472-9646-1-git-send-email-alex.aring@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1438772472-9646-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de

I added this change to this patch:

diff --git a/src/info.c b/src/info.c
index fd75fa0..e00ed3e 100644
--- a/src/info.c
+++ b/src/info.c
@@ -212,6 +212,7 @@ static const char *commands[NL802154_CMD_MAX + 1] = {
        [NL802154_CMD_SET_BACKOFF_EXPONENT] = "set_backoff_exponent",
        [NL802154_CMD_SET_MAX_CSMA_BACKOFFS] = "set_max_csma_backoffs",
        [NL802154_CMD_SET_LBT_MODE] = "set_lbt_mode",
+       [NL802154_CMD_SET_ACKREQ_DEFAULT] = "set_ackreq_default",
 };
 
 static char cmdbuf[100];


For dumping that we will support "set_ackreq_default" which all current
SoftMAC transceivers supports.

- Alex
