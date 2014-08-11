Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f176.google.com ([74.125.82.176]:48630 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751686AbaHKL7d (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 11 Aug 2014 07:59:33 -0400
Received: by mail-we0-f176.google.com with SMTP id q58so8405437wes.35
        for <linux-wpan@vger.kernel.org>; Mon, 11 Aug 2014 04:59:32 -0700 (PDT)
Received: from omega (p20030064A9351216E2CB4EFFFE1BB546.dip0.t-ipconnect.de. [2003:64:a935:1216:e2cb:4eff:fe1b:b546])
        by mx.google.com with ESMTPSA id e3sm1125067wjp.4.2014.08.11.04.59.31
        for <linux-wpan@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Aug 2014 04:59:31 -0700 (PDT)
Date: Mon, 11 Aug 2014 13:59:29 +0200
From: Alexander Aring <alex.aring@gmail.com>
Message-ID: <20140811115927.GB24354@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
Subject: re- force-updating wpan repositories
To: linux-wpan@vger.kernel.org

Hi,

sorry. I need to do a force update again. You will getting trouble if
you do a "git pull". Please do a git reset or re checkout the wpan
repository.

And we have now a wpan and wpan-next. New features should base on
wpan-next. I reconsider this and we should not base everything on
wpan-next.

Sorry, I need some time to setup my git. After I have a working
environment this will never happen (I hope).

- Alex
