Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:42460 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753359AbbCIJji (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 9 Mar 2015 05:39:38 -0400
Received: by widex7 with SMTP id ex7so17853721wid.1
        for <linux-wpan@vger.kernel.org>; Mon, 09 Mar 2015 02:39:37 -0700 (PDT)
Date: Mon, 9 Mar 2015 10:39:34 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [RFC bluetooth-next 2/2] at86rf230: add support for dt or pdata
 extended addr
Message-ID: <20150309093933.GC711@omega>
References: <1425802643-5798-1-git-send-email-alex.aring@gmail.com>
 <1425802643-5798-3-git-send-email-alex.aring@gmail.com>
 <20150309093637.GB711@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20150309093637.GB711@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, mkl@pengutronix.de

> Or should I define it driver specific. When setting "extended-addr" via
> the dt property "extended-addr" then because the driver doesn't support
> the handling.

s/dt property "extended-addr"/dt property "extended-addr" doesn't work/

sorry, I hope now it's clear what I meant here.

- Alex
