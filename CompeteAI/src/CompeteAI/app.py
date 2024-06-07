import streamlit as st


def main():
    st.title("CompeteAI: Competitive Programming with LLM")
    st.write(
        "Welcome to CompeteAI. Start solving problems and get real-time feedback from the LLM!"
    )

    input_type = st.radio("入力方法を選択してください", ("URL入力", "テキスト直接入力"))

    if input_type == "URL入力":
        url = st.text_input("ここに問題のURLを入力")
    else:
        text = st.text_area("ここに問題のテキストを入力")


if __name__ == "__main__":
    main()
