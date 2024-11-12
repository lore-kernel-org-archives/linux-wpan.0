Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830AB41C79
	for <linux-wpan@vger.kernel.org>; Tue, 12 Nov 2024 04:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731385868; cv=none; b=VBFhgKwUrAExY4E24cBWudEGeDENS2sF9EDDyfWe7lOxN8xHLn8TSbaps6I1GHBn6Nh7Db8JleMxaq5Jac2ZbTu6QY1VBvjBjQ72L3KeRzFZ+jwuc0A1gfNcpqAOHkrHTiQPPsLcEWGVbQzfXTTvDne+ouyCqUZndXwq5ixSk9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731385868; c=relaxed/simple;
	bh=UXtpxBefUNr3VcIYNI9rVjNQrYCyWHXXzZkWnLQ35Tc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gp8829AaSloK4cnez4JMEQ0hZIZ4TdHGfealYVHc/M/EGPN3QxmywLi44V3TAxPCExqKTLVI8F5FX0HL1xskIxQlYHYfIC8XftU9LIrFXtS08K2L8xiS9Az3oFvBeNGZ5NHnjeA3a9KlaelED4Bob53ODOLSbKPAIQaCRtd2InQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a6c1907eeaso65637425ab.1
        for <linux-wpan@vger.kernel.org>; Mon, 11 Nov 2024 20:31:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731385867; x=1731990667;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=57INWnZiq0HfAnj9yObF5CBGSGscztNUCHjuo+6K0KI=;
        b=oDxsvYN7QclgaGeXvLgn2mJQ/nehnoegtb8z9LSWV6/pxZdr3NM80f017kO6JOqm3J
         XOO0clQCkcI+pqDHwneDbF5ADJMgxqVk0AOpUOI2VNgwOBxh9s0W1eTx62gYTYvjIB1X
         l9fl8L0iUOFmS/x5POlMKCeYCRYCMnKQcz9urt+6KlJmjyMdOcle+ivQ/6GrRuOVWhhZ
         Wn5Rh6+G03mzKp74wH6B4U9AOmq0ks/tB31YsVlHgO6W8TvbLyugtpZ91+iz/ixxfoKA
         Y2bZXlfPZTOEOrcTWnH3fbLZ4+1w0gKXKyJW73WOyKYKLH77phNEAc9VNSNuDYgVaJTo
         NlKA==
X-Forwarded-Encrypted: i=1; AJvYcCXt7xQuyOLLbea3m+kuzUuAFOhwFsyYymb8twAeyVUzRIQUw74jy6VHY3xvdKLJpjvRV/UgKElZHCd8@vger.kernel.org
X-Gm-Message-State: AOJu0YydZCeRsAQqgZVJfcjzqp0pqLdHh+GAfScYvgwJbYhexrA6EEvf
	7pNJfjF4BhqpeE4Nce7EbhSD9k0YyhdYyZ1TnVi7NTxQyl4KKPzGJXpdaUlEmdkWgvoZa4ommNc
	+mS736oQfcdNVCH+e4FI8rQ+pYGCFbtq/tN51LavnghuNnIHmEV1DMzs=
X-Google-Smtp-Source: AGHT+IFFUDjXKPivqzf1Tpm1sYMybaBdZY0FjaiXxICZysfVPEn6SL2GpDXPpaOREbFWte39HRrYxumuNBSVZgs5bBmZdVwHU/rz
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1908:b0:3a4:ebfa:2ac7 with SMTP id
 e9e14a558f8ab-3a6f1a0a674mr158303905ab.12.1731385866731; Mon, 11 Nov 2024
 20:31:06 -0800 (PST)
Date: Mon, 11 Nov 2024 20:31:06 -0800
In-Reply-To: <20241112002134.2003089-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6732da0a.050a0220.5088e.0005.GAE@google.com>
Subject: Re: [syzbot] [wpan?] [usb?] BUG: corrupted list in ieee802154_if_remove
From: syzbot <syzbot+985f827280dc3a6e7e92@syzkaller.appspotmail.com>
To: alex.aring@gmail.com, davem@davemloft.net, dmantipov@yandex.ru, 
	edumazet@google.com, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-wpan@vger.kernel.org, lizhi.xu@windriver.com, miquel.raynal@bootlin.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, stefan@datenfreihafen.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+985f827280dc3a6e7e92@syzkaller.appspotmail.com
Tested-by: syzbot+985f827280dc3a6e7e92@syzkaller.appspotmail.com

Tested on:

commit:         2d5404ca Linux 6.12-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1608335f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1503500c6f615d24
dashboard link: https://syzkaller.appspot.com/bug?extid=985f827280dc3a6e7e92
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=109ed35f980000

Note: testing is done by a robot and is best-effort only.
