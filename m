Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:33136 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753455AbbE1PY4 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 28 May 2015 11:24:56 -0400
Received: by wicmx19 with SMTP id mx19so127184111wic.0
        for <linux-wpan@vger.kernel.org>; Thu, 28 May 2015 08:24:55 -0700 (PDT)
Date: Thu, 28 May 2015 17:24:52 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH,RFC bluetooth-next 2/2] ieee802154: Fix EUI-64 station
 address validation.
Message-ID: <20150528152451.GB31492@omega>
References: <53cacc49e75b59f7b6458075b032be16f1133abb.1432816524.git.buytenh@wantstofly.org>
 <20150528123843.GE11340@wantstofly.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20150528123843.GE11340@wantstofly.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: linux-wpan@vger.kernel.org

On Thu, May 28, 2015 at 03:38:43PM +0300, Lennert Buytenhek wrote:
> Refuse to allow setting an EUI-64 group address as an interface
> address, as those are not valid station addresses.
> 
> Signed-off-by: Lennert Buytenhek <buytenh@wantstofly.org>

Acked-by: Alexander Aring <alex.aring@gmail.com>
