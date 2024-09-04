Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2D718C902
	for <linux-wpan@vger.kernel.org>; Wed,  4 Sep 2024 08:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725438626; cv=none; b=ol1Qai8BzGxkBFaSAXi09H30oxuauW36YP3aYs8nEYBS8Gn+Da6pdfi6AkDb/HztPLrOmUBjPQnZh/HaiW2zoVq1gbwbCZ89jutaacHrDruLABINPu5bONHxwtAAOJzBduV52HtowEgLUh+9uS7FCBIUmDcAb0pHfQZZTTcY9YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725438626; c=relaxed/simple;
	bh=qcSXkF2eeVbXnz/TGB7tvcwJtXcMcs1eddCFuoy6vt0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UMWKbr8vS9hoUiUdVp/mrWxbBdhddn8Ac0FR2zR7JEYg+GoJm9jmMlehvlqEN9iy9CCtmWAGa/LrLUQX95bg/YN2AkdXSx/JMhg3Ckdx7zsHjuqkXR58PkgTSAOZN+LNDPpdQ+r2gSNEIPZWGHS771qUdcM8hmR5BFhbucCJdOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82a3fa4ecd3so78740339f.1
        for <linux-wpan@vger.kernel.org>; Wed, 04 Sep 2024 01:30:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725438624; x=1726043424;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=riEJj9yptEntwWm8uC4noCWANnp3aNiR1XVqLGvV3To=;
        b=ZUlb/5oiMEJdo+SSvGM/d0A8+h+SbP60A9wLOdwrgPlPH+pDrz8mma2mKFCMVMplfd
         poJrbpDGGGm7YX/ibqalP+gyOvloV2GdHKOdHg6INKk/IDGdU50n6Be1qt3YYnbVcSq6
         /fwsa4WPHSsouVB6XTuQuxbeV2f+0Jc9SQfTLrZmbLGcvTUPxnt2v1/gqEl5RyOadDNU
         b9T9VQneg37zxHuLVp/wGapVcfeUqtCg/OfB9LGr3r6eJU7MGiW4fYBVf03ZHFbcQeb9
         HJFUv6w0nEjjUSwd3YKfo4xfgSSk7u89TDu5ddS8SM3WL5K287CtY0VxdMTSAyCFvYKi
         rYGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwTB3x4J39vUaS4wlJDpnKRKmKt/zNmpbU36rGmWxwJzd7EIUvdxDwAz5G+068PBHCn684uB7jxfk/@vger.kernel.org
X-Gm-Message-State: AOJu0Yx38wJ/wTf4PLEQLLGDcf58+mrq8Gui2halT3chDtvviiWJwuFC
	GtSEGMAPl4Ihh5eMIzGpl1+ZT8QOlqJG47obQ5mFy0MgJ9+ztmgytrdcIfe9M/fr1AXAnrkMWPf
	OGkaQfVVIVhsPyLV9aF/lSjN23UA2kVefSLPVaJV49JNG8eNmDHCbND4=
X-Google-Smtp-Source: AGHT+IFf1N79VFCXobIPXbsA0DCA/+/jvIHiGNZkPocqGC8SqI64i4RB4lO0DtdwLR1uojTxi3MkPM7uX1EFYS4pE5neID6NzICK
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:860d:b0:4c2:7945:5a32 with SMTP id
 8926c6da1cb9f-4d05e776145mr84665173.5.1725438624417; Wed, 04 Sep 2024
 01:30:24 -0700 (PDT)
Date: Wed, 04 Sep 2024 01:30:24 -0700
In-Reply-To: <000000000000a45a92061ce6cc7d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004a5da1062146fc27@google.com>
Subject: Re: [syzbot] [wpan?] WARNING in __dev_change_net_namespace (2)
From: syzbot <syzbot+1df6ffa7a6274ae264db@syzkaller.appspotmail.com>
To: alex.aring@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-wpan@vger.kernel.org, 
	miquel.raynal@bootlin.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	stefan@datenfreihafen.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    88fac17500f4 Merge tag 'fuse-fixes-6.11-rc7' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1547d653980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=660f6eb11f9c7dc5
dashboard link: https://syzkaller.appspot.com/bug?extid=1df6ffa7a6274ae264db
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13bf3fdb980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-88fac175.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/de92cf928379/vmlinux-88fac175.xz
kernel image: https://storage.googleapis.com/syzbot-assets/253b0e12054b/bzImage-88fac175.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1df6ffa7a6274ae264db@syzkaller.appspotmail.com

R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 0000000000000000 R14: 00007f95c6735f80 R15: 00007ffd0db2c528
 </TASK>
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5268 at net/core/dev.c:11568 __dev_change_net_namespace+0x171a/0x1830 net/core/dev.c:11568
Modules linked in:
CPU: 0 UID: 0 PID: 5268 Comm: syz.0.15 Not tainted 6.11.0-rc6-syzkaller-00026-g88fac17500f4 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:__dev_change_net_namespace+0x171a/0x1830 net/core/dev.c:11568
Code: 01 90 48 c7 c7 40 dc 0c 8d 48 c7 c6 20 dc 0c 8d ba c5 2c 00 00 e8 e6 d8 cb f7 90 0f 0b 90 90 e9 54 ea ff ff e8 a7 b4 09 f8 90 <0f> 0b 90 e9 4a fb ff ff e8 99 b4 09 f8 90 0f 0b 90 e9 d5 fe ff ff
RSP: 0018:ffffc90002456fc0 EFLAGS: 00010293
RAX: ffffffff8989d809 RBX: dffffc0000000000 RCX: ffff88801cbe2440
RDX: 0000000000000000 RSI: 00000000fffffff4 RDI: 0000000000000000
RBP: ffffc900024573f8 R08: ffffffff8989d349 R09: 1ffffffff283c909
R10: dffffc0000000000 R11: fffffbfff283c90a R12: ffff88803362c1b8
R13: ffff88803362cbf0 R14: ffff88803362c734 R15: 00000000fffffff4
FS:  00007f95c734f6c0(0000) GS:ffff88801fe00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd5dd5ec6d6 CR3: 0000000011730000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 dev_change_net_namespace include/linux/netdevice.h:3932 [inline]
 cfg802154_switch_netns+0xc8/0x390 net/ieee802154/core.c:230
 nl802154_wpan_phy_netns+0x13d/0x210 net/ieee802154/nl802154.c:1292
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0xb14/0xec0 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2550
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2597
 ___sys_sendmsg net/socket.c:2651 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2680
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f95c657cef9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f95c734f038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f95c6735f80 RCX: 00007f95c657cef9
RDX: 0000000000000000 RSI: 0000000020000280 RDI: 0000000000000006
RBP: 00007f95c734f090 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 0000000000000000 R14: 00007f95c6735f80 R15: 00007ffd0db2c528
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
