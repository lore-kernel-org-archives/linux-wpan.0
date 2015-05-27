Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:37307 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185AbbE0GzM (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 27 May 2015 02:55:12 -0400
Received: by wifw1 with SMTP id w1so9857814wif.0
        for <linux-wpan@vger.kernel.org>; Tue, 26 May 2015 23:55:11 -0700 (PDT)
Date: Wed, 27 May 2015 08:54:59 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [RFC bluetooth-next] atusb: add support for at86rf230
Message-ID: <20150527065454.GA712@omega>
References: <1432471383-5029-1-git-send-email-alex.aring@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1432471383-5029-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Stefan Schmidt <stefan@osg.samsung.com>

Stefan,

On Sun, May 24, 2015 at 02:43:03PM +0200, Alexander Aring wrote:
> This patch adds support for the at86rf230 version check which is used
> by the rzusb stick.
> 

is it okay to apply this patch for mainline for now? Then it's only a
question to make _better_ patches for the atusb firmware. Werner told me
that I should remove the a lot of ifdefs or we landing in a ifdef hell
which is like a well known IoT-OS and that's true. Was a dirty hack.

If it's okay then I will send a patch again.

- Alex
