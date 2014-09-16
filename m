Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f169.google.com ([74.125.82.169]:55409 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752067AbaIPHCC (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 16 Sep 2014 03:02:02 -0400
Received: by mail-we0-f169.google.com with SMTP id w61so5233178wes.0
        for <linux-wpan@vger.kernel.org>; Tue, 16 Sep 2014 00:02:01 -0700 (PDT)
Date: Tue, 16 Sep 2014 09:01:58 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH wpan-next] ieee802154: mrf24j40: support for external
 rx/tx
Message-ID: <20140916070156.GB1244@omega>
References: <1410759338-21663-1-git-send-email-wmack@componentsw.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1410759338-21663-1-git-send-email-wmack@componentsw.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Walter Mack <wmack@componentsw.com>
Cc: linux-wpan@vger.kernel.org, alan@signal11.us, simon.vincent@xsilon.com

Alan,

ping?

This looks for me like what Simon Vincent has send about a month ago.

I like more to check on chip revision instead setting module parameter,
but you have the last word.

Please, handle this in any way which you like. I see now there comming
more patches for the same issue, I don't like that. We should add
support for this.

- Alex
