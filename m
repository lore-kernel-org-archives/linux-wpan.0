Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:34796 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752228AbbFIHwH (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 9 Jun 2015 03:52:07 -0400
Received: by wibut5 with SMTP id ut5so8878862wib.1
        for <linux-wpan@vger.kernel.org>; Tue, 09 Jun 2015 00:52:06 -0700 (PDT)
Date: Tue, 9 Jun 2015 09:52:00 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH] mac802154/iface: remove superfluous WARN_ON call in
 slave_open()
Message-ID: <20150609075010.GA1402@omega>
References: <1433794000-10501-1-git-send-email-stefan@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1433794000-10501-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan@vger.kernel.org

On Mon, Jun 08, 2015 at 10:06:40PM +0200, Stefan Schmidt wrote:
> This call was used before we aligned our code with the wireless code base. We
> are wanted to handle this in the err: code path. Which would actually not work
> because the WARN_ON() macro would reset the res value to 0 and thus we would
> never hit err:. Removing it makes the code do what we actually intend.
> 
> Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>

Acked-by: Alexander Aring <alex.aring@gmail.com>

Please next time "subsytem: file:" or only "subsytem:" in the subject.
But not "subsytem/subsubsystem:". Thanks.

- Alex
