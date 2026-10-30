Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793362476;
	b=m50lfovGo1snnjIOd/xyL2DtG/4zbQ0haBGPLMYuJZum8uey44qA2rUtukSEXLtfxR01
	 B1xn+cPxjiCxtB8bh6Kc6NvbTvFsdlEZZqPpk/qjXWY07b0IVdsXWv92El5ipoW3ZokKq
	 ccvl65slurK0OOyPIfnVWy7UkY0F75ZpWhGggqjffbLqn6gFtZ/+cI3R68h25IHEI9Jtt
	 fTY1SxB8cJXAlsVnLRtHtORj9+M+y8TSaqu/qK69NJqcgs7D2tEKm+dKMMmBB+0+l5Wsf
	 /7HHyIj5r+GAysx9x+WJLhpd/NxwrZULBLZuQHQvaTxtqXR/w+3BPNVSSAUUyLoV3pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793362476;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=fIsZN7+4fkQBsb9F8HsQdpPNVBhUbbSPmwMZcGaHUyM=;
	b=BRKVOPwwMOpJSvo0IsdvQ+hfZcmxQPPgFdcYczG0jl9akbGy1BGirXJX9mp8yVQLFblI
	 UF3mMpUeUN19d0vFtjpDs8O3mGp9JWdLSbSKqBBk4RG9Sc/TMyhGbjXbC5o3EOhK8YxAi
	 KoDPbfYMvx8uN//VbZ+yp9lguenqtcHqG562S98jfPuZQaBo33kY2SF3AFmGy6P/4Zs16
	 4f+CrKxgHKGhGH/e0Wv3RSovbXOIybs5gV8BUxUqyiy+thshyiIQpkpxlgp+2NNVBQP7F
	 RECxYv9UcV91K1e2g1cFeN/tvGQrPVAO+XJ4Te54r3pPcSOFy6nrmUriDVxx68x1kpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.197
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41373606A32D
	for <linux-wpan@vger.kernel.org>; Fri, 30 Oct 2026 12:14:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41373606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-547ae874949so911257b6e.2
        for <linux-wpan@vger.kernel.org>; Fri, 30 Oct 2026 05:14:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793362475; x=1793967275;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fIsZN7+4fkQBsb9F8HsQdpPNVBhUbbSPmwMZcGaHUyM=;
        b=AFUuq5ZfCup5M+8LYy7YG9t5DFO0or0tm6jdnYMBbTYFkTXve2sVzZyE2Jm/QYo9Bq
         t7vEJmJuXLuQpfOGP0AZMCn1jWLjTUfJ0NVN4a68CEMAetkbUvA6mLwg9ZnSbu/oU+zv
         sq5h0Qv5/ksO1LowXmYdKi59VVBqSb7niTm3k1R1M0nohh2S70+UqTUm2qPOG8M7fetl
         OmiPxM/+u3TmeiffTiQRT1p7dT19uvrLq6GhkbDjajDZca+9m8BN7xNnihrh2/9dYeH2
         KHEZ/M2Chfk0vI+C99Vo8sy1KAs1DqtydRrd5vmA9uFD+3ClNxZ3i8t29MWUrwNI9wB+
         kQVQ==
X-Forwarded-Encrypted: i=1; AKwUvBy8Qdiwna+n9hZ7ARONmaIqwcct1BMqs0B2bB8IKSbIlgQW6Kw3mrGoWyx7A90Vk36Bds9gPrLb40cP@vger.kernel.org
X-Gm-Message-State: AFq9FYLGvNXSn93TL040ScXHuGGdBo+UJKu3tXE3p7kHOA3zlQG6t2wA
	/iefKgZBgUfKMvWdMC0J1kfuUZ+fzirhpf0GTHiu7yCqzFG+jsfWCfUTpLy/aq7YFQOqmChhr5F
	nyaPnkkuMmgatQbWqP/RXA173HT0TN8TsqlAKaG9SI/wwawKqq6ErOdPV+O0=
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Post: <mailto:linux-wpan@vger.kernel.org>
List-Help: <mailto:linux-wpan+help@vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-wpan+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:4704:b0:4f1:6c9c:78d3 with SMTP id
 5614622812f47-5640df39312mr1305526b6e.26.1793362475290; Fri, 30 Oct 2026
 05:14:35 -0700 (PDT)
Date: Fri, 30 Oct 2026 05:14:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ae48a2b.6713f5d0.92cad.0001.GAE@google.com>
Subject: [syzbot] [wpan?] general protection fault in ieee802154_llsec_dump_table
 (2)
From: syzbot <syzbot+9ea34da5ca6100593c90@syzkaller.appspotmail.com>
To: alex.aring@gmail.com, linux-kernel@vger.kernel.org, 
	linux-wpan@vger.kernel.org, miquel.raynal@bootlin.com, netdev@vger.kernel.org, 
	stefan@datenfreihafen.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c339f4010dea Merge tag 'platform-drivers-x86-v7.4-1' of gi..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15a3dd95580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=119e5f4d0a8d39cf
dashboard link: https://syzkaller.appspot.com/bug?extid=9ea34da5ca6100593c90
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=151a448d580000

AI-generated root cause summary:
In net/ieee802154/nl-mac.c, ieee802154_llsec_dump_table() iterates through all
network devices in the namespace and assumes any device with dev->type ==
ARPHRD_IEEE802154 has a non-NULL ml_priv pointing to struct ieee802154_mlme_ops.
However, devices such as TUN can have their link type changed to
ARPHRD_IEEE802154 via the TUNSETLINK ioctl without initializing ml_priv (leaving
it NULL). Consequently, ieee802154_llsec_dump_table() dereferences
data.ops->llsec at offset 0x38 of a NULL pointer when dumping LLSEC tables,
leading to a general protection fault / kernel crash (Denial of Service).

full analysis:  https://syzkaller.appspot.com/x/ai_root_cause?x=9ea34da5ca6100593c90

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9ea34da5ca6100593c90@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000007: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000038-0x000000000000003f]
CPU: 0 UID: 0 PID: 6025 Comm: syz-executor400 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/15/2026
RIP: 0010:ieee802154_llsec_dump_table+0x204/0x5d0 net/ieee802154/nl-mac.c:778
Code: 89 f8 48 c1 e8 03 80 3c 18 00 0f 85 d3 02 00 00 4d 8b be b8 07 00 00 49 8d 7f 38 4c 89 bc 24 98 00 00 00 48 89 f8 48 c1 e8 03 <80> 3c 18 00 0f 85 a5 02 00 00 4d 8b 7f 38 4d 85 ff 0f 84 b2 01 00
RSP: 0018:ffffc900031ef4a0 EFLAGS: 00010202
RAX: 0000000000000007 RBX: dffffc0000000000 RCX: 0000000000000000
RDX: ffff8880314ccb00 RSI: ffffffff8b9ff162 RDI: 0000000000000038
RBP: 0000000000000026 R08: 0000000000000324 R09: 0000000000000324
R10: ffffc900031ef40f R11: ffffc900031ef520 R12: ffff888036830610
R13: 0000000000000000 R14: ffff88805d7a8000 R15: 0000000000000000
FS:  000055558d27f400(0000) GS:ffff88812248e000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fff8aa5bff8 CR3: 000000002ce9b000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 genl_dumpit+0x125/0x230 net/netlink/genetlink.c:1026
 netlink_dump+0x53b/0xd00 net/netlink/af_netlink.c:2351
 __netlink_dump_start+0x6d6/0x990 net/netlink/af_netlink.c:2466
 genl_family_rcv_msg_dumpit+0x1e2/0x2e0 net/netlink/genetlink.c:1075
 genl_family_rcv_msg net/netlink/genetlink.c:1191 [inline]
 genl_rcv_msg+0x471/0x800 net/netlink/genetlink.c:1209
 netlink_rcv_skb+0x159/0x420 net/netlink/af_netlink.c:2576
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1218
 netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
 netlink_unicast+0x668/0x950 net/netlink/af_netlink.c:1361
 netlink_sendmsg+0x9ac/0x10c0 net/netlink/af_netlink.c:1920
 sock_sendmsg_nosec net/socket.c:800 [inline]
 __sock_sendmsg net/socket.c:818 [inline]
 __sys_sendto+0x492/0x4e0 net/socket.c:2283
 __do_sys_sendto net/socket.c:2290 [inline]
 __se_sys_sendto net/socket.c:2286 [inline]
 __x64_sys_sendto+0xe0/0x1c0 net/socket.c:2286
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0fada8d8b7
Code: 48 89 fa 4c 89 df e8 98 1d 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
RSP: 002b:00007fff8aa5c1d0 EFLAGS: 00000202 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 000055558d27f400 RCX: 00007f0fada8d8b7
RDX: 0000000000000014 RSI: 00007fff8aa5c220 RDI: 0000000000000004
RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 00007f0fadac9d23
R13: 00007fff8aa5c390 R14: 000000000000001d R15: 0000000000000002
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ieee802154_llsec_dump_table+0x204/0x5d0 net/ieee802154/nl-mac.c:778
Code: 89 f8 48 c1 e8 03 80 3c 18 00 0f 85 d3 02 00 00 4d 8b be b8 07 00 00 49 8d 7f 38 4c 89 bc 24 98 00 00 00 48 89 f8 48 c1 e8 03 <80> 3c 18 00 0f 85 a5 02 00 00 4d 8b 7f 38 4d 85 ff 0f 84 b2 01 00
RSP: 0018:ffffc900031ef4a0 EFLAGS: 00010202
RAX: 0000000000000007 RBX: dffffc0000000000 RCX: 0000000000000000
RDX: ffff8880314ccb00 RSI: ffffffff8b9ff162 RDI: 0000000000000038
RBP: 0000000000000026 R08: 0000000000000324 R09: 0000000000000324
R10: ffffc900031ef40f R11: ffffc900031ef520 R12: ffff888036830610
R13: 0000000000000000 R14: ffff88805d7a8000 R15: 0000000000000000
FS:  000055558d27f400(0000) GS:ffff88812258e000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffdac0fedc4 CR3: 000000002ce9b000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	89 f8                	mov    %edi,%eax
   2:	48 c1 e8 03          	shr    $0x3,%rax
   6:	80 3c 18 00          	cmpb   $0x0,(%rax,%rbx,1)
   a:	0f 85 d3 02 00 00    	jne    0x2e3
  10:	4d 8b be b8 07 00 00 	mov    0x7b8(%r14),%r15
  17:	49 8d 7f 38          	lea    0x38(%r15),%rdi
  1b:	4c 89 bc 24 98 00 00 	mov    %r15,0x98(%rsp)
  22:	00
  23:	48 89 f8             	mov    %rdi,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	80 3c 18 00          	cmpb   $0x0,(%rax,%rbx,1) <-- trapping instruction
  2e:	0f 85 a5 02 00 00    	jne    0x2d9
  34:	4d 8b 7f 38          	mov    0x38(%r15),%r15
  38:	4d 85 ff             	test   %r15,%r15
  3b:	0f                   	.byte 0xf
  3c:	84                   	.byte 0x84
  3d:	b2 01                	mov    $0x1,%dl


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
