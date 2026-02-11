import re
import json
import base64
from playwright.sync_api import Page, expect
import pytest
from pathlib import Path

file_url = Path("index.html").resolve().as_uri()


@pytest.fixture
def page_root(page: Page, base_url: str):
    url = base_url if base_url else file_url
    page.goto(url)
    # Wait for MicroPython to be ready
    page.wait_for_function('typeof mp_js_init === "function"', timeout=10000)
    return page


def test_execution_success(page_root: Page):
    page_root.fill("#src", 'print("hello")')
    page_root.fill("#target", "hello")

    # MicroPython execution is triggered on input
    expect(page_root.locator("#mp_js_stdout")).to_have_text(re.compile(r"hello\s*✔️"))


def test_execution_failure(page_root: Page):
    page_root.fill("#src", 'print("hello")')
    page_root.fill("#target", "world")

    expect(page_root.locator("#mp_js_stdout")).to_have_text(re.compile(r"hello\s*❌️"))


def test_load_from_hash(page: Page, base_url: str):
    data = ['print("hi")', "hi"]
    hash_val = base64.b64encode(json.dumps(data).encode()).decode()
    url = base_url if base_url else file_url
    page.goto(f"{url}#{hash_val}")

    page.wait_for_function('typeof mp_js_init === "function"', timeout=10000)

    expect(page.locator("#src")).to_have_value('print("hi")')
    expect(page.locator("#target")).to_have_value("hi")
    expect(page.locator("#mp_js_stdout")).to_have_text(re.compile(r"hi\s*✔️"))


def test_traceback(page_root: Page):
    page_root.fill("#src", "1/0")

    # ZeroDivisionError: division by zero (line 1)
    expect(page_root.locator("#mp_js_stdout")).to_contain_text("ZeroDivisionError")
    expect(page_root.locator("#mp_js_stdout")).to_contain_text("(line 1)")
